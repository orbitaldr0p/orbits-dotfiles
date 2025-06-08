import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
import "root:"

MouseArea {
    Layout.preferredWidth: batteryRow.width
    Layout.preferredHeight: batteryRow.height
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor

    onClicked: mouse => {
        switch (mouse.button) {
            case Qt.LeftButton:
                Power.batteryMonitor()
                break;
            case Qt.RightButton:
                Power.changePowerProfile()
                break;
        }
    }

    Row {
        id: batteryRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 5

        Text {
            text: Power.batIcon
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Math.round(Power.batPercent * 100) + "%"
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Power.isCharging ? Colors.green : (Power.batPercent < 0.2 ? Colors.red : Colors.text)
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
