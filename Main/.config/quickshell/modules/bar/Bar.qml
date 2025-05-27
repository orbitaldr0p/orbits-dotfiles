import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "root:/data/"
import "widgets"

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

                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: height / 4
                    anchors.rightMargin: height / 4
                    width: implicitWidth
                    spacing: height / 4
                    
                    Workspaces {}
                }

                RowLayout {
                    id: barMiddle

                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.leftMargin: height / 4
                    anchors.rightMargin: height / 4
                    width: implicitWidth
                    spacing: height / 4

                    Clock {
                        color: Colors.text
                        font.family: Fonts.normalFont
                        font.pointSize: 12
                        font.bold: true
                    }

                }

            }

        }

    }

}
