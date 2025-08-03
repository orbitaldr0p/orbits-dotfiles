pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.data
import qs.common
import qs.config

Rectangle {
    Layout.preferredWidth: ramRow.width
    Layout.preferredHeight: ramRow.height
    color: "transparent"
    Row {
        id: ramRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 5

        CircularProgress {
            id: mediaIcon
            lineWidth: 2
            value: Resources.memPercent / 100
            size: 26
            Text {
                text: "  "
                font.family: Fonts.monoFont
                font.pointSize: 16
                font.bold: true
                color: Colors.text
                anchors.centerIn: parent
            }
        }

        Text {
            text: Resources.memPercent.toString() + "%"
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: true
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignLeft
        }
    }
    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.small
            easing.type: Easing.InOutQuad
        }
    }
}
