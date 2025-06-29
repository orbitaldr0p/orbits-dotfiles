pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
import "root:/common/"
import "root:/config/"


MouseArea {
	Layout.preferredWidth: brightessRow.width
	Layout.preferredHeight: brightessRow.height
	onWheel: event => {
		if (event.angleDelta.y > 0) {
			Brightness.increase()
		} else {
			Brightness.decrease()
		}
	}
	Row {
		id: brightessRow
		Layout.alignment: Qt.AlignVCenter
		spacing: 5

		Text {
			text: Brightness.brightnessIcon
			font.family: Fonts.normalFont
			font.pointSize: 12
			font.bold: true
			color: Colors.text
			anchors.verticalCenter: parent.verticalCenter
		}

		Text {
			text: Math.round(Brightness.brightnessPercent * 100) + "%";
			font.family: Fonts.normalFont
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
