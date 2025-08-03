pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config

Scope {
    id: root
    readonly property list<real> cpuCoresPercent: Resources.cpuCoresPercent
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property var realPlayers: Mpris.players.values.filter(player => isRealPlayer(player))
    readonly property var meaningfulPlayers: filterDuplicatePlayers(realPlayers)

    //stolen from end-4, ty :3
    function isRealPlayer(player) {
        // return true
        return (
            // playerctld just copies other buses and we don't need duplicates
            !player.dbusName?.startsWith('org.mpris.MediaPlayer2.playerctld') &&
            // Non-instance mpd bus
            !(player.dbusName?.endsWith('.mpd') && !player.dbusName.endsWith('MediaPlayer2.mpd')));
    }

    function filterDuplicatePlayers(players) {
        let filtered = [];
        let used = new Set();

        for (let i = 0; i < players.length; ++i) {
            if (used.has(i)) continue;
            let p1 = players[i];
            let group = [i];

            // Find duplicates by trackTitle prefix
            for (let j = i + 1; j < players.length; ++j) {
                let p2 = players[j];
                if (p1.trackTitle && p2.trackTitle &&
                    (p1.trackTitle.includes(p2.trackTitle)
                        || p2.trackTitle.includes(p1.trackTitle))
                        || (p1.position - p2.position <= 2 && p1.length - p2.length <= 2)) {
                    group.push(j);
                }
            }

            // Pick the one with non-empty trackArtUrl, or fallback to the first
            let chosenIdx = group.find(idx => players[idx].trackArtUrl && players[idx].trackArtUrl.length > 0);
            if (chosenIdx === undefined) chosenIdx = group[0];

            filtered.push(players[chosenIdx]);
            group.forEach(idx => used.add(idx));
        }
        return filtered;
    }

    Loader {
        id: mediaControlsLoader
        active: false
        sourceComponent: PanelWindow {
            visible: true
            exclusiveZone: 0

            anchors {
                top: true
                left: true
            }
            margins {
                top: 5
                bottom: 0
                left: 280
                right: 0
            }

            color: "transparent"
            implicitWidth: mediaColumnLayout.implicitWidth
            implicitHeight: mediaColumnLayout.implicitHeight

            ColumnLayout {
                id: mediaColumnLayout
                anchors {
                    top: parent.top
                    bottom: parent.bottom
                }
                spacing: 10
                Repeater {
                    model: root.meaningfulPlayers
                    Item {
                        required property MprisPlayer modelData

                        implicitWidth: playerControl.implicitWidth
                        implicitHeight: playerControl.implicitHeight
                        PlayerControl {
                            id: playerControl
                            player: modelData
                        }
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "mediaControls"
        function toggle(): void {
            mediaControlsLoader.active = !mediaControlsLoader.active;
        }
    }

    GlobalShortcut {
        name: "mediaControlsToggle"
        description: qsTr("Toggles cpu popup on press")
        onPressed: {
            mediaControlsLoader.active = !mediaControlsLoader.active;
        }
    }
}
