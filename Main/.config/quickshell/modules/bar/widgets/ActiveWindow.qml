pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Wayland
import "root:/data/"
import "root:/common/"
import "root:/config/"


Item {
	id : root
	readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
	property string targetWinName: activeWindow ?. activated ? activeWindow ?. title : ""
	property string displayedWinName

	width: textContainer.width
	height: textContainer.height
	clip: true

	Timer {
		id: updateTimer
		interval: 0
		running: false
		repeat: false
		onTriggered: {
			displayedWinName = targetWinName
			fadeInAnim.start()
		}
	}

	onTargetWinNameChanged: {
		if (displayedWinName !== "") {
			fadeOutAnim.start();
		} else {
			displayedWinName = targetWinName;
			fadeInAnim.start();
		}
	}

	ParallelAnimation {
		id: fadeOutAnim
		PropertyAnimation { target: windowName; property: "opacity"; to: 0.0; duration: Globals.anim.durations.small/2; easing.type: Easing.Linear }
		PropertyAnimation { target: horizontalScale; property: "xScale"; to: 0.8; duration: Globals.anim.durations.small; easing.bezierCurve: Globals.anim.curves.slideout; easing.type: Easing.BezierSpline }
		onStopped: {
			updateTimer.start()
		}
	}

	ParallelAnimation {
		id: fadeInAnim
		PropertyAnimation { target: windowName; property: "opacity"; from: 0.0; to: 1.0; duration: Globals.anim.durations.small/2; easing.type: Easing.Linear }
		PropertyAnimation { target: horizontalScale; property: "xScale"; from: 0.8; to: 1.0; duration: Globals.anim.durations.small; easing.bezierCurve: Globals.anim.curves.slideout; easing.type: Easing.BezierSpline }
	}

    Rectangle {
        id: textContainer
        width: 500
        height: windowName.implicitHeight
        anchors.centerIn: parent
        color: "transparent"

		Text {
			id: windowName
			text: root.displayedWinName
			font.family: Fonts.monoFont
			font.pointSize: 11
			font.bold: true
			color: Colors.text

			width: textContainer.width
			elide: Text.ElideRight
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter

			transformOrigin: Item.Center
			opacity: 1.0
			transform: Scale {
				id: horizontalScale
				origin.x: windowName.width / 2
				origin.y: windowName.height / 2
				xScale: 1.0
				yScale: 1.0
			}
		}
    }
}
