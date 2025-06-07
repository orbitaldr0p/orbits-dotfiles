import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "root:/data/"
import "root:"

Item {
	id : root
	
	implicitWidth: Math.min(Math.max(activeWindowText.implicitWidth, 1), 500)
	implicitHeight: activeWindowText.implicitHeight

	clip: true
	property string actWinName: activeWindow ?. activated ? activeWindow ?. title : ""
	readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

	Text {
		id: activeWindowText
		text: root.actWinName
		color: Colors.text
		font.family: Fonts.normalFont
		font.pointSize: 11
		font.bold: true
		anchors.left: parent.left
		anchors.verticalCenter: parent.verticalCenter
		elide: Text.ElideRight
		width: parent.width
	}

	Behavior on implicitWidth {
		NumberAnimation {
			duration: Globals.anim.durations.normal
			easing.bezierCurve: Globals.anim.curves.slideout
			easing.type: Easing.BezierSpline
		}
	}
}