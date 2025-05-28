import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "root:/data/"

Row {
    Layout.alignment: Qt.AlignVCenter
    spacing: 10

    Text {
        text: ""
        font.family: Fonts.monoFont
        font.pointSize: 16
        font.bold: true
        color: Colors.text
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: Resources.cpuPercent + "%"
        font.family: Fonts.monoFont
        font.pointSize: 11
        font.bold: true
        color: Colors.text
        anchors.verticalCenter: parent.verticalCenter
    }

}
