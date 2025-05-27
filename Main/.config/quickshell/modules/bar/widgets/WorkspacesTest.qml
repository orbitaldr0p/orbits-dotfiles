import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "root:/data/"

Rectangle {
    id: workspaces

    Layout.preferredWidth: workspaceRow.width
    color: "transparent"
    height: bar.height

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
            id: workspacesRepeater

            model: Math.max(HyprlandUtils.maxWorkspace, 5)

            Rectangle {
                id: ws

                required property int index
                property HyprlandWorkspace currWorkspace: Hyprland.workspaces.values.find((e) => {
                    return e.id == index + 1;
                }) || null
                property bool nonexistent: currWorkspace === null
                property bool focused: Hyprland.focusedMonitor !== null && Hyprland.focusedMonitor.activeWorkspace !== null && index + 1 === Hyprland.focusedMonitor.activeWorkspace.id
                property bool hovered: false

                radius: height / 2
                Layout.preferredWidth: {
                    return focused ? parent.height * 0.8 : parent.height * 0.4;
                }
                Layout.preferredHeight: parent.height * 0.4
                color: {
                    if (focused)
                        return Colors.text;
                    else
                        return Colors.withAlpha(Colors.text, 0.5);
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                }

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                }

            }

        }

    }

}
