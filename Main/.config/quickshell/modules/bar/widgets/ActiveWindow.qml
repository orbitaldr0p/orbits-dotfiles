import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "root:/data/"

Item {
	id : root
	
	implicitWidth : activeWindowText.implicitWidth
	implicitHeight : activeWindowText.implicitHeight

	clip : true
	property string actWinName : activeWindow ?. activated ? activeWindow ?. title : ""
	readonly property Toplevel activeWindow : ToplevelManager.activeToplevel

	Text {
		id : activeWindowText
		text : root.actWinName
		color : Colors.text
		font.family : Fonts.normalFont
		font.pointSize : 11
		font.bold : true
		anchors.centerIn : parent
	}

	Behavior on implicitWidth {
        NumberAnimation {
            duration: 300
            easing.bezierCurve: [0.23, 1, 0.61, 1, 1, 1]
            easing.type: Easing.BezierSpline
        }
	}
}
