import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/data/"
import "root:"

Rectangle {
    id: workspaces

    property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)

    Layout.preferredWidth: workspaceRow.width
    Layout.preferredHeight : workspaceRow.height
    color: "transparent"

    RowLayout {
        id: workspaceRow
        height: 35
        layoutDirection: Qt.LeftToRight

        Repeater {
            model: Math.max(HyprlandUtils.maxWorkspace, 5)

            MouseArea {
                id: workspaceButton
                required property int index
                property HyprlandWorkspace currWorkspace: Hyprland.workspaces.values.find((e) => {
                    return e.id == index + 1;
                }) || null
                property bool nonexistent: currWorkspace === null
                property bool focused: Hyprland.focusedMonitor !== null && Hyprland.focusedMonitor.activeWorkspace !== null && index + 1 === Hyprland.focusedMonitor.activeWorkspace.id
                property bool hovered: false

                Layout.preferredWidth: {
                    return focused ? parent.height * 0.4 : parent.height * 0.4;
                }
                Layout.preferredHeight: parent.height * 0.4
                hoverEnabled: true
                onEntered: (event) => {
                    return workspaceIndicator.hovered = true;
                }
                onExited: (event) => {
                    return workspaceIndicator.hovered = false;
                }
                onClicked: (event) => {
                    return Hyprland.dispatch(`workspace ${index+1}`);
                }

                Text {
                    id: workspaceIndicator
                    property bool hovered: false
                    anchors.centerIn: parent
                    text: {
                        const symbols = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"];
                        return symbols[index] || (index + 1).toString();
                    }
                    font.pointSize: 14
                    font.family: Fonts.chineseFont
                    font.bold: true
                    color: {
                        if (focused)
                            return Colors.text;
                        if (hovered)
                            return Colors.text;
                        return Colors.withAlpha(Colors.text, 0.5);
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: Globals.anim.durations.small
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.small
            easing.type: Easing.InOutQuad
        }
    }
}
