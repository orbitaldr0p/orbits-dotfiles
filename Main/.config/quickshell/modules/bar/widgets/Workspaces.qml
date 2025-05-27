import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "root:/data/"

Rectangle {
    // clip: true

    id: workspaces

    property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)

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
                    return focused ? parent.height * 0.8 : parent.height * 0.4;
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

                Rectangle {
                    id: workspaceIndicator

                    property bool hovered: false

                    anchors.centerIn: parent
                    anchors.fill: parent
                    radius: height / 2
                    color: {
                        if (focused)
                            return Colors.text;

                        if (hovered)
                            return Colors.text;

                        return Colors.withAlpha(Colors.text, 0.5);
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }

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

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 50
            easing.type: Easing.OutQuad
        }

    }

}
