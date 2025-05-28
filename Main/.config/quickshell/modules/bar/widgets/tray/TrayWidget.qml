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

            Item {
                width: trayIcon.implicitWidth
                height: trayIcon.implicitHeight

                Item {
                    id: trayIconWrapper

                    width: trayIcon.implicitWidth
                    height: trayIcon.implicitHeight
                    y: hovered ? 3 : 0 // Apply vertical offset here

                    Label {
                        id: trayIcon

                        anchors.centerIn: parent
                        opacity: 1
                        text: hovered ? "󱊔" : "󱊖"
                        color: Colors.text
                        font.family: Fonts.normalFont
                        font.pointSize: 16
                        font.bold: true
                        onTextChanged: {
                            trayIcon.opacity = 0;
                            trayIcon.opacity = 1;
                        }

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 100
                            }

                        }

                    }

                }

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
