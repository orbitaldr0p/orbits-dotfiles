import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
MouseArea {
	Layout.preferredWidth : brightessRow.width
	Layout.preferredHeight : brightessRow.height
	onWheel : event => {
		if (event.angleDelta.y > 0) {
			Brightness.increase()
		} else {
			Brightness.decrease()
		}
	}
	Row {
		id : brightessRow
		Layout.alignment : Qt.AlignVCenter
		spacing : 5

		Text {
			text : Brightness.brightnessIcon
			font.family : Fonts.monoFont
			font.pointSize : 14
			font.bold : true
			color : Colors.text
			anchors.verticalCenter : parent.verticalCenter
		}

		Text {
			text : Math.round(Brightness.brightnessPercent * 100) + "%";
			font.family : Fonts.monoFont
			font.pointSize : 11
			font.bold : true
			color : Colors.text
			anchors.verticalCenter : parent.verticalCenter
		}
	}
	Behavior on Layout.preferredWidth {
		NumberAnimation {
			duration : 200
			easing.type : Easing.InOutQuad
		}

	}
}
