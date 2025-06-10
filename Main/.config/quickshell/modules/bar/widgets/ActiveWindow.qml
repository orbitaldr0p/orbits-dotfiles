import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "root:/data/"
import "root:"

Item {
	id : root
	
	width: 500
	height: textContainer.height

	clip: true
	readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
	property string targetWinName: activeWindow ?. activated ? activeWindow ?. title : ""
	property string displayedWinName

	// Trigger animation when targetWinName changes
	Timer {
		id: updateTimer
		interval: 0
		running: false
		repeat: false
		onTriggered: {
			// After fade-out is done, update text and start fade-in
			displayedWinName = targetWinName
			fadeInAnim.start()
		}
	}

	// Fade-out + scale-down when targetWinName changes
	onTargetWinNameChanged: {
		fadeOutAnim.start()
	}

	// Fade-out animation
	ParallelAnimation {
		id: fadeOutAnim
		PropertyAnimation { target: windowName; property: "opacity"; to: 0.0; duration: Globals.anim.durations.small; easing.bezierCurve: Globals.anim.curves.slideout; easing.type: Easing.BezierSpline }
		PropertyAnimation { target: windowName; property: "scale"; to: 0.8; duration: Globals.anim.durations.small; easing.bezierCurve: Globals.anim.curves.slideout; easing.type: Easing.BezierSpline }
		onStopped: {
			updateTimer.start()
		}
	}

	// Fade-in animation
	ParallelAnimation {
		id: fadeInAnim
		PropertyAnimation { target: windowName; property: "opacity"; from: 0.0; to: 1.0; duration: Globals.anim.durations.small; easing.bezierCurve: Globals.anim.curves.slideout; easing.type: Easing.BezierSpline }
		PropertyAnimation { target: windowName; property: "scale"; from: 1.2; to: 1.0; duration: Globals.anim.durations.small; easing.bezierCurve: Globals.anim.curves.slideout; easing.type: Easing.BezierSpline }
	}

    Rectangle {
        id: textContainer
        width: parent.width
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
            scale: 1.0
        }
    }
}
