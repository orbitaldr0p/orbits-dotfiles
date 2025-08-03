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

    Layout.preferredWidth: hovered ? batteryRow.width : batteryRowRetracted.width
    Layout.preferredHeight: batteryRow.height
    clip: true

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        onEntered: {
            root.hovered = true;
            Hyprland.dispatch("global quickshell:batteryPopupToggle");
        }
        onExited: {
            root.hovered = false;
            Hyprland.dispatch("global quickshell:batteryPopupToggle");
        }

        onClicked: mouse => {
            switch (mouse.button) {
            case Qt.LeftButton:
                Power.batteryMonitor();
                break;
            case Qt.RightButton:
                Power.changePowerProfile();
                break;
            }
        }
    }

    Row {
        id: batteryRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 10
        Row {
            id: batteryRowRetracted
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4
            CircularProgress {
                id: mediaIcon
                lineWidth: 2
                value: Power.batPercent / 1
                primaryColor: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
                secondaryColor: Power.isCharging ? Colors.withAlpha(Colors.green, 0.5) : (Power.batPercent < 0.2 ? Colors.withAlpha(Colors.red, 0.5) : Colors.withAlpha(Colors.text, 0.5))
                size: 26
                Text {
                    text: " " + Power.batIcon + " "
                    font.family: Fonts.monoFont
                    font.pointSize: 11
                    font.bold: true
                    color: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
                    anchors.centerIn: parent
                }
            }

            /* Text {
            text: Power.batIcon
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
            anchors.verticalCenter: parent.verticalCenter
        } */

            Text {
                text: Math.round(Power.batPercent * 100) + "%"
                font.family: Fonts.monoFont
                font.pointSize: 11
                font.bold: true
                color: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            id: batteryRowExpanded
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            Text {
                visible: !(Power.battery.timeToEmpty === 0 && Power.battery.timeToFull === 0)
                text: StringUtils.timeConverter(Power.battery.timeToEmpty === 0 ? Power.battery.timeToFull : Power.battery.timeToEmpty) + " " + (Power.battery.timeToEmpty === 0 ? "till full" : "till empty")
                font.family: Fonts.monoFont
                font.pointSize: 11
                font.bold: true
                color: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
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
