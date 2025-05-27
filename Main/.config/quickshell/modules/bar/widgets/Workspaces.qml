pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "root:/data/"

Rectangle {
    id: workspaces

    color: 'transparent'
    width: workspacesRow.implicitWidth
    Layout.fillHeight: true

    RowLayout {
        id: workspacesRow

        height: parent.height
        implicitWidth: (parent.height * 0.5 + spacing) * 2 - spacing
        anchors.centerIn: parent
        spacing: height / 7

        Repeater {
            id: repeater

            model: HyprlandUtils.maxWorkspace

            Workspace {
                id: ws

                required property int index
                property HyprlandWorkspace currWorkspace: Hyprland.workspaces.values.find((e) => {
                    return e.id == index + 1;
                }) || null
                property bool nonexistent: currWorkspace === null
                property bool focused: Hyprland.focusedMonitor !== null && Hyprland.focusedMonitor.activeWorkspace !== null && index + 1 === Hyprland.focusedMonitor.activeWorkspace.id

                Layout.preferredWidth: {
                    if (!parent || typeof parent.height === 'undefined')
                        return 0;

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
