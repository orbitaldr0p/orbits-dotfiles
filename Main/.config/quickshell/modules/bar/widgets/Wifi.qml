import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"

MouseArea {
    Layout.preferredWidth: wifiRow.width
    Layout.preferredHeight: wifiRow.height
    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor

    onClicked: Network.launchWifiMenu()

    Row {
        id: wifiRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 5

        Text {
            text: Network.netIcon
            font.family: Fonts.monoFont
            font.pointSize: 17
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: Network.networkName
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
}
