pragma ComponentBehavior: Bound

import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/data/"
import "root:/common/"
import "root:/config/"

Scope {
    id: root
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property var players: Mpris.players.values
    readonly property real widgetWidth: 600
    readonly property real widgetHeight: 300
    property real contentPadding: 13
    property real popupRounding: 5
    property real artRounding: 5

    Loader {
        id: mediaControlsLoader
        active: false
        sourceComponent: PanelWindow {
            id: mediaControlsRoot
            WlrLayershell.namespace: "quickshell:mediaControls"

            visible: true
            exclusiveZone: 0
            
            anchors {
                top: true
                left: true
            }
            margins {
				top : 5
				bottom : 0
				left : 5
				right : 5
			}
            color: "transparent"
            implicitWidth: playerColumnLayout.implicitHeight
            implicitHeight: playerColumnLayout.implicitHeight
            mask: Region {
                item: playerColumnLayout
            }

            ColumnLayout {
                id: playerColumnLayout
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                x: 0
                spacing: 10
                Repeater {
                    model: ScriptModel {
                        values: root.players
                    }
                    delegate: PlayerControl {
                        required property MprisPlayer modelData
                        player: modelData
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "mediaControls"

        function toggle(): void {
            mediaControlsLoader.active = !mediaControlsLoader.active;
            if(mediaControlsLoader.active) Notifications.timeoutAll();
        }

        function close(): void {
            mediaControlsLoader.active = false;
        }

        function open(): void {
            mediaControlsLoader.active = true;
            Notifications.timeoutAll();
        }
    }

    GlobalShortcut {
        name: "mediaControlsToggle"
        description: qsTr("Toggles media controls on press")
        onPressed: {
            if (!mediaControlsLoader.active && players.length === 0) {
                return;
            }
            mediaControlsLoader.active = !mediaControlsLoader.active;
        }
    }

    GlobalShortcut {
        name: "mediaControlsOpen"
        description: qsTr("Opens media controls on press")
        onPressed: {
            mediaControlsLoader.active = true;
            Notifications.timeoutAll();
        }
    }

    GlobalShortcut {
        name: "mediaControlsClose"
        description: qsTr("Closes media controls on press")
        onPressed: {
            mediaControlsLoader.active = false;
        }
    }
}