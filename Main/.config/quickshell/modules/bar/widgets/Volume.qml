import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
MouseArea {
	Layout.preferredWidth : volumeRow.width
	Layout.preferredHeight : volumeRow.height
	acceptedButtons : Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
	cursorShape : Qt.PointingHandCursor

	onClicked : mouse => {
		switch (mouse.button) {
			case Qt.LeftButton:
				Audio.launchAudioManagement()
				break;
			case Qt.MiddleButton:
				Audio.micMute()
				break;
			case Qt.RightButton:
				Audio.mute()
				break;
		}
	}
	onWheel : event => {
		if (event.angleDelta.y > 0) {
			Audio.increase()
		} else {
			Audio.decrease()
		}
	}
	Row {
		id : volumeRow
		Layout.alignment : Qt.AlignVCenter
		spacing : 5

		Text {
			text : Audio.volIcon
			font.family : Fonts.monoFont
			font.pointSize : 14
			font.bold : true
			color : Colors.text
			anchors.verticalCenter : parent.verticalCenter
		}

		Text {
			text : Math.round(Audio.volume * 100) + "%";
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
