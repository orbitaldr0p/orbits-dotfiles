pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.data
import qs.common
import qs.config

MouseArea {
    Layout.preferredWidth: bluetoothRow.width
    Layout.preferredHeight: bluetoothRow.height
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor

    onClicked: Bluetooth.launchBTMenu()

    Row {
        id: bluetoothRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 5

        Text {
            text: Bluetooth.powered ? "" : "󰂲"
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            visible: Bluetooth.powered
            text: {
                const connectedDevices = Bluetooth.devices.filter(d => d.connected);
                return connectedDevices.length > 0 ? connectedDevices.length.toString() : "On";
            }
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.small
            easing.type: Easing.InOutQuad
        }
    }
}
