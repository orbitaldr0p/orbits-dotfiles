pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config

Scope {
    id: root
    readonly property list<real> cpuCoresPercent: Resources.cpuCoresPercent
    Loader {
        id: cpuPopupLoader
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
                left: 10
                right: 0
            }
            color: "transparent"
            implicitWidth: cpuColumnLayout.implicitWidth
            implicitHeight: cpuColumnLayout.implicitHeight + 10

            Rectangle {
                anchors.fill: parent
                radius: 5
                color: Colors.withAlpha(Colors.base, 0.5)
                ColumnLayout {
                    id: cpuColumnLayout
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                        topMargin: 5
                        bottomMargin: 5
                    }
                    spacing: 10
                    Repeater {
                        model: root.cpuCoresPercent
                        Item {
                            required property int index
                            required property string modelData

                            implicitWidth: coreStat.implicitWidth
                            implicitHeight: coreStat.implicitHeight
                            Text {
                                id: coreStat
                                text: " Core " + String(index).padStart(2, "0") + ": " + String(Math.round(parseFloat(modelData))).padStart(2, "0") + "% "
                                color: modelData < 1 ? Colors.withAlpha(Colors.text, 0.5) : modelData >= 80 ? Colors.red : Colors.text
                                font.family: Fonts.monoFont
                                font.pointSize: 10
                            }
                        }
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "cpuPopup"
        function toggle(): void {
            cpuPopupLoader.active = !cpuPopupLoader.active;
        }
    }

    GlobalShortcut {
        name: "cpuPopupToggle"
        description: qsTr("Toggles cpu popup on press")
        onPressed: {
            cpuPopupLoader.active = !cpuPopupLoader.active;
        }
    }
}
