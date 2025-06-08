import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
import "root:"

MouseArea {
    id:root
    property bool hovered: false
    Layout.preferredWidth: hovered ? wifiRow.width : wifiIcon.width
    Layout.preferredHeight: wifiRow.height
    cursorShape: Qt.PointingHandCursor
    clip: true

    hoverEnabled: true
    onClicked: Network.launchWifiMenu()
    onEntered: root.hovered = true
    onExited: root.hovered = false

    Row {
        id: wifiRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 5

        Text {
            id: wifiIcon
            text: Network.netIcon
            font.family: Fonts.monoFont
            font.pointSize: 17
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Network.active ? Network.active.ssid : "disconnected"
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.normal
            easing.bezierCurve: Globals.anim.curves.bg
            easing.type: Easing.BezierSpline
        }
    }
}
