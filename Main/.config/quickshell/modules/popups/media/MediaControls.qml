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

    function isRealPlayer(player) {
        // return true
        return (
            // playerctld just copies other buses and we don't need duplicates
            !player.dbusName?.startsWith('org.mpris.MediaPlayer2.playerctld') &&
            // Non-instance mpd bus
            !(player.dbusName?.endsWith('.mpd') && !player.dbusName.endsWith('MediaPlayer2.mpd')));
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
                    model: root.realPlayers
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
