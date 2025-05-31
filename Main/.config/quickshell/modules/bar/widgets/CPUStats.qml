import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "root:/data/"


MouseArea {
	Layout.preferredWidth : cpuRow.width
	Layout.preferredHeight : cpuRow.height
	acceptedButtons : Qt.LeftButton | Qt.RightButton
	cursorShape : Qt.PointingHandCursor

	onClicked : mouse => {
		switch (mouse.button) {
			case Qt.LeftButton:
				Resources.systemMonitor()
				break;
			case Qt.RightButton:
				Resources.gpuMonitor()
				break;
		}
	}
	Row {
		id : cpuRow
		Layout.alignment : Qt.AlignVCenter
		spacing : 5

		Text {
			text : ""
			font.family : Fonts.monoFont
			font.pointSize : 18
			font.bold : true
			color : Colors.text
			anchors.verticalCenter : parent.verticalCenter
		}

		Text {
			text : Resources.cpuPercent.toString() + "%"
			font.family : Fonts.monoFont
			font.pointSize : 11
			font.bold : true
			color : Colors.text
			anchors.verticalCenter : parent.verticalCenter
			horizontalAlignment : Text.AlignLeft
		}

	}
	Behavior on Layout.preferredWidth {
		NumberAnimation {
			duration : 200
			easing.type : Easing.InOutQuad
		}

	}
}
