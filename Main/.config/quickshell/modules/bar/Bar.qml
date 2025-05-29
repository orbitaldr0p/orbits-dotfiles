import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "root:/data/"
import "widgets"
import "widgets/tray"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            property var modelData

            screen: modelData
            implicitHeight: 30
            color: "transparent"

            margins {
                top: 5
                bottom: 0
                left: 5
                right: 5
            }

            anchors {
                top: true
                left: true
                right: true
            }

            Rectangle {
                anchors.fill: parent
                radius: 5
                color: Colors.withAlpha(Colors.base, 0.5)

                RowLayout {
                    id: barLeft

                    spacing: height / 4

                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: height / 3
                    }

                    CPUStats {
                    }

                    RAMStats {
                    }

                    Seperator {
                    }

                    Workspaces {
                    }

                    Seperator {
                    }

                    TrayWidget {
                    }

                }

                RowLayout {
                    id: barMiddle

                    spacing: height / 4

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    Clock {
                    }

                }

                RowLayout {
                    id: barRight

                    spacing: height / 4

                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: height / 3
                    }

                    Clock {
                    }

                    Seperator {
                    }

                }

            }

        }

    }

}
