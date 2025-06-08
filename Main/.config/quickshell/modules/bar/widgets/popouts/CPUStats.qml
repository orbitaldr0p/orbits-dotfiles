import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "root:/data/"

PanelWindow {
	id : bar
	property var modelData
	screen : modelData
	implicitHeight : 30
	color : "transparent"
	margins {
		top : 5
		bottom : 0
		left : 5
		right : 5
	}
	anchors {
		top : true
		left : true
		right : true
	}

	Rectangle {
		anchors.fill : parent
		radius : 5
		color : Colors.withAlpha(Colors.base, 0.5)
	}
}
