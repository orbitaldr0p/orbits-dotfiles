import QtQuick
import QtQuick.Layouts
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
            id: workspacesRepeater

            model: HyprlandUtils.maxWorkspace

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
                Layout.preferredHeight: parent.height * 0.4
                Layout.preferredWidth: {
                    if (!parent || typeof parent.height === 'undefined')
                        return 0.4;

                    return focused ? parent.height * 0.8 : parent.height * 0.4;
                }
                color: {
                    if (nonexistent) {
                        return Colors.withAlpha(Colors.text, 0.5);
                    } else {
                        const monitorIndex = Hyprland.monitors.values.indexOf(Hyprland.workspaces.values.find((e) => {
                            return e.id === index + 1;
                        }).monitor);
                        const monitorColors = [Colors.text];
                        return monitorColors[monitorIndex % monitorColors.length];
                    }
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
