import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "root:/data/"
import "root:"

Rectangle {
	id: root
	property bool hovered: false
	color: "transparent"
	Layout.preferredWidth: hovered ? sysTrayWrapper.width: trayIconWrapper.width
	height: trayIconWrapper.height
	clip: true

	RowLayout {
		id: sysTrayWrapper
		anchors.verticalCenter: parent.verticalCenter
		spacing: 10

		Item {
			id: trayIconWrapper
			width: trayIcon.width
			height: trayIcon.height
			Label {
				id: trayIcon
				anchors.centerIn: parent
				opacity: hovered ? 0: 1
				text: "󱊖"
				color: Colors.text
				font.family: Fonts.normalFont
				font.pointSize: 16
				font.bold: true
				Behavior on opacity {
					NumberAnimation {
						duration: Globals.anim.durations.small / 2
					}
				}
			}
			Item {
				width: trayIconHovered.width
				height: trayIconHovered.height
				y: 3
				Label {
					id: trayIconHovered
					anchors.centerIn: parent
					opacity: 1
					text: "󱊔"
					color: Colors.text
					font.family: Fonts.normalFont
					font.pointSize: 16
					font.bold: true
				}
			}
		}

		Repeater {
			id: sysTrayRow
			model: SystemTray.items
			visible: hovered
			TrayItem {
				required property SystemTrayItem modelData
				item: modelData
			}
		}
	}

	MouseArea {
		id: hoverArea
		anchors.fill: parent
		hoverEnabled: true
		onEntered: root.hovered = true
		onExited: root.hovered = false
		z: -1
	}

	Behavior on Layout.preferredWidth {
		NumberAnimation {
			duration: Globals.anim.durations.normal
			easing.bezierCurve: Globals.anim.curves.slideout
			easing.type: Easing.BezierSpline
		}
	}
}
