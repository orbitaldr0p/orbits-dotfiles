import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/data/"

Rectangle {
    id: workspaces

    Layout.preferredWidth: workspaceRow.width
    color: "transparent"
    height: bar.height - 7
    radius: height / 2
    // clip: true

    property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)

    RowLayout {
        id: workspaceRow
        height: 35
        layoutDirection: Qt.LeftToRight

        anchors {
            right: parent.right
            rightMargin: 10
            centerIn: parent
        }

        Repeater {

            model: ScriptModel {
                values: [...Hyprland.workspaces.values.filter(entry => (entry.monitor?.id ?? -1) === monitor.id).sort((a, b) => a.id - b.id)]
            }

            MouseArea {
                id: workspaceButton
                required property HyprlandWorkspace modelData

                implicitWidth: 24
                implicitHeight: 22

                property bool isActive: false

                hoverEnabled: true

                onEntered: event => rect.hovered = true
                onExited: event => rect.hovered = false

                onClicked: event => Hyprland.dispatch(`workspace ${modelData.id}`)

                Rectangle {
                    id: rect

                    anchors.centerIn: parent
                    anchors.fill: parent

                    // implicitWidth: 24
                    radius: height / 2

                    property bool hovered: false
                    property bool current: (workspaces.monitor.activeWorkspace?.id ?? -1) == modelData.id

                    color: {
                        if (hovered) {
                            return Colors.text;
                        }

                        if (current) {
                            return Colors.text;
                        }

                        return Colors.withAlpha(Colors.text, 0.5);;
                    }

                    Text {
                        anchors.centerIn: parent

                        // HACK: convert hyprsplit IDs to visual IDs
                        text: modelData.id - workspaces.monitor.id * 9
                        font.pointSize: 13
                        color: Colors.base
                    }
                }
            }
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 50
            easing.type: Easing.OutQuad
        }
    }
}
