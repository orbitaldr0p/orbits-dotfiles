import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "root:/data/"
import "root:"

Item {
	id : root
	
	implicitWidth: Math.min(Math.max(activeWindowRow.implicitWidth, 1), 500)
	implicitHeight: activeWindowRow.implicitHeight

	clip: true
	readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
	property string actWinName: activeWindow ?. activated ? activeWindow ?. title : ""
	property string text1: actWinName.substring(0, actWinName.length/2)
	property string text2: actWinName.substring(actWinName.length/2)

	Row {
		id: activeWindowRow
		anchors.centerIn: parent
		spacing: 0

		Text {
			text : root.text1
			font.family : Fonts.monoFont
			font.pointSize : 11
			font.bold : true
			color : Colors.text
		}

		Text {
			text : root.text2
			font.family : Fonts.monoFont
			font.pointSize : 11
			font.bold : true
			color : Colors.text
		}
	}

	Behavior on implicitWidth {
		NumberAnimation {
			duration: Globals.anim.durations.normal
			easing.bezierCurve: Globals.anim.curves.slideout
			easing.type: Easing.BezierSpline
		}
	}
}