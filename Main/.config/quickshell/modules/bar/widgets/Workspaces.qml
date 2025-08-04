pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config


Item {
    id: workspaces

    property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)

    Layout.preferredWidth: workspaceRow.width
    Layout.preferredHeight : workspaceRow.height

    RowLayout {
        id: workspaceRow
        height: 35
        layoutDirection: Qt.LeftToRight

        Repeater {
            model: Math.max(HyprlandUtils.maxWorkspace, 5)

            Rectangle {
                id: workspaceButton
                required property int index
                property HyprlandWorkspace currWorkspace: Hyprland.workspaces.values.find((e) => {
                    return e.id == index + 1;
                }) || null
                property bool nonexistent: currWorkspace === null
                property bool focused: Hyprland.focusedMonitor !== null && Hyprland.focusedMonitor.activeWorkspace !== null && index + 1 === Hyprland.focusedMonitor.activeWorkspace.id
                property bool hovered: false

                Layout.preferredWidth: parent.height * 0.5
                Layout.preferredHeight: parent.height
                color: "transparent"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: {
                        workspaceButton.hovered = true;
                    }
                    onExited: {
                        workspaceButton.hovered = false;
                    }
                    onClicked: {
                        Hyprland.dispatch(`workspace ${workspaceButton.index+1}`);
                    }
                }

                Text {
                    id: workspaceIndicator
                    anchors.centerIn: parent
                    text: {
                        const symbols = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"];
                        return symbols[workspaceButton.index] || (workspaceButton.index + 1).toString();
                    }
                    font.pointSize: 14
                    font.family: Fonts.chineseFont
                    font.bold: true
                    color: {
                        if (workspaceButton.focused)
                            return Colors.text;
                        if (workspaceButton.hovered)
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
			easing.bezierCurve: Globals.anim.curves.slideout
			easing.type: Easing.BezierSpline
        }
    }
}
