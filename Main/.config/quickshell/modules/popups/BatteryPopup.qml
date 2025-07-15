pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import "root:/data/"
import "root:/common/"
import "root:/config/"

Scope {
    id: root
    property var currentBattery: Power.battery
    Loader {
        id: batteryPopupLoader
        active: false
        sourceComponent: PanelWindow {
            visible: true
            exclusiveZone: 0

            anchors {
                top: true
                right: true
            }
            margins {
                top: 5
                bottom: 0
                left: 0
                right: 5
            }
            color: "transparent"
            implicitWidth: 400
            implicitHeight: 130

            Rectangle {
                anchors.fill: parent
                radius: 5
                color: Colors.withAlpha(Colors.base, 0.5)
                ColumnLayout {
                    spacing: 2
                    Text {
                        id: batteryHealth
                        text: `Health: ${(root.currentBattery.energyCapacity / 90 * 100).toFixed(2)}%`
                        color: Colors.text
                        font.family: Fonts.normalFont
                        font.pointSize: 10
                    }
                    Text {
                        id: trackArtist
                        text: `${Power.isCharging ? 'Charge Rate' : 'Drain Rate'}: ${root.currentBattery.changeRate}W`
                        color: Colors.text
                        font.family: Fonts.normalFont
                        font.pointSize: 10
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "batteryPopup"
        function toggle(): void {
            batteryPopupLoader.active = !batteryPopupLoader.active;
        }
    }

    GlobalShortcut {
        name: "batteryPopupToggle"
        description: qsTr("Toggles battery popup on press")
        onPressed: {
            batteryPopupLoader.active = !batteryPopupLoader.active;
        }
    }
}
