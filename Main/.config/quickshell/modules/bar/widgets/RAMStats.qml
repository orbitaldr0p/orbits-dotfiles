import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
import "root:/common/"
import "root:"

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
			MaterialSymbol {
				anchors.centerIn: parent
				fill: 1
				text: "memory_alt"
				iconSize: 14
				color: Colors.text
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
