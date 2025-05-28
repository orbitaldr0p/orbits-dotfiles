import "../"
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "root:/data/"

Rectangle {
    id: root

    property bool hovered: false

    color: "transparent"
    implicitHeight: 40
    implicitWidth: trayWrapper.width

    // Main wrapper with dynamic width
    Rectangle {
        id: trayWrapper

        height: parent.height
        width: hovered ? rowL.implicitWidth + 20 : 20
        color: "transparent"
        clip: true

        RowLayout {
            id: rowL

            anchors.verticalCenter: parent.verticalCenter
            spacing: 10

            Label {
                text: "" // 
                color: Colors.text
                font.family: Fonts.normalFont
                font.pointSize: 11
                font.bold: true
            }

            Seperator {
            }

            Repeater {
                model: SystemTray.items
                visible: hovered

                TrayItem {
                    required property SystemTrayItem modelData

                    item: modelData
                }

            }

        }

        MouseArea {
            id: hoverArea

            anchors.fill: parent
            hoverEnabled: true
            onEntered: root.hovered = true
            onExited: root.hovered = false
        }

        Behavior on width {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }

        }

    }

}
