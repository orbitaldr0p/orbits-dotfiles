import "../data"
import "../widgets"
import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            property var modelData

            screen: modelData
            implicitHeight: 30
            color: Colors.withAlpha(Colors.base, 0.5)

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

            Clock {
                anchors.centerIn: parent
                color: Colors.text
                font.family: Fonts.normalFont
                font.pointSize: 12
                font.bold: true
            }

        }

    }

}
