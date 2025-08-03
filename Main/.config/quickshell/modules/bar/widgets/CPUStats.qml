pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config

Item {
    id: root
    property bool hovered: false
    Layout.preferredWidth: hovered ? cpuRow.width : cpuPercentRow.width
    Layout.preferredHeight: cpuRow.height
    clip: true

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: {
            root.hovered = true;
            Hyprland.dispatch("global quickshell:cpuPopupToggle");
        }
        onExited: {
            root.hovered = false;
            Hyprland.dispatch("global quickshell:cpuPopupToggle");
        }

        onClicked: mouse => {
            switch (mouse.button) {
            case Qt.LeftButton:
                Resources.systemMonitor();
                break;
            case Qt.RightButton:
                Resources.gpuMonitor();
                break;
            }
        }
    }

    Row {
        id: cpuRow
        spacing: 10
        Layout.alignment: Qt.AlignVCenter
        Row {
            id: cpuPercentRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4
            CircularProgress {
                id: mediaIcon
                lineWidth: 2
                value: Resources.cpuPercent / 100
                primaryColor: Resources.cpuPercent >= 80 ? Colors.red : Colors.text
                secondaryColor: Resources.cpuPercent >= 80 ? Colors.withAlpha(Colors.red, 0.5) : Colors.withAlpha(Colors.text, 0.5)
                size: 26
                Text {
                    text: "  "
                    font.family: Fonts.monoFont
                    font.pointSize: 16
                    font.bold: true
                    color: Resources.cpuPercent >= 80 ? Colors.red : Colors.text
                    anchors.centerIn: parent
                }
            }
            Text {
                text: Resources.cpuPercent.toString() + "%"
                font.family: Fonts.normalFont
                font.pointSize: 11
                font.bold: true
                color: Resources.cpuPercent >= 80 ? Colors.red : Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: cpuTempRow
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            Text {
                text: Resources.tempIcon
                font.family: Fonts.normalFont
                font.pointSize: 11
                font.bold: true
                color: Resources.cpuTemp >= 80 ? Colors.red : Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
            Text {
                text: Resources.cpuTemp.toString() + "°C"
                font.family: Fonts.normalFont
                font.pointSize: 11
                font.bold: true
                color: Resources.cpuTemp >= 80 ? Colors.red : Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.normal
            easing.bezierCurve: Globals.anim.curves.slideout
            easing.type: Easing.BezierSpline
        }
    }
}
