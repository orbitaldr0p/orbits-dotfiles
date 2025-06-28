import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "root:/data/"
import "root:/common/"
import "root:"

MouseArea {
	id: root
	property bool hovered: false
	Layout.preferredWidth : hovered ? cpuRow.width : cpuPercentRow.width
	Layout.preferredHeight : cpuRow.height
	clip: true

	acceptedButtons : Qt.LeftButton | Qt.RightButton
	cursorShape : Qt.PointingHandCursor
	hoverEnabled: true
    onEntered: root.hovered = true
    onExited: root.hovered = false

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
		spacing: parent.parent.height/4
		Layout.alignment : Qt.AlignVCenter
		Row {
			id : cpuPercentRow
			anchors.verticalCenter : parent.verticalCenter
			spacing : 4
			CircularProgress {
				id: mediaIcon
				lineWidth: 2
				value: Resources.cpuPercent / 100
				size: 26
				MaterialSymbol {
					anchors.centerIn: parent
					fill: 1
					text: "memory"
					iconSize: 18
					color: Colors.text
				}
			}
			Text {
				text : Resources.cpuPercent.toString() + "%"
				font.family : Fonts.normalFont
				font.pointSize : 11
				font.bold : true
				color : Colors.text
				anchors.verticalCenter : parent.verticalCenter
			}
		}

		Row {
			id : cpuTempRow
			anchors.verticalCenter : parent.verticalCenter
			spacing : 5
			Text {
				text : Resources.tempIcon
				font.family : Fonts.normalFont
				font.pointSize : 11
				font.bold : true
				color : Colors.text
				anchors.verticalCenter : parent.verticalCenter
			}
			Text {
				text : Resources.cpuTemp.toString() + "°C"
				font.family : Fonts.normalFont
				font.pointSize : 11
				font.bold : true
				color : Colors.text
				anchors.verticalCenter : parent.verticalCenter
			}
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
