import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "root:/data/"
import "root:"

Rectangle {
	id: root
	property bool hovered: false
    property var iconSize: 17
    color: "transparent"
    Layout.preferredWidth: hovered ? miscWrapper.width : miscIconWrapper.width
    height: miscWrapper.height
    anchors.right: parent.right
    clip: true

    Row {
        id: miscWrapper
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        spacing: 10

        Item {
            width: clipHistIcon.implicitWidth
            height: clipHistIcon.implicitHeight
            Text {
                id: clipHistIcon
                text: ""
                font.family: Fonts.monoFont
                font.pointSize: root.iconSize
                font.bold: true
                color: Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.launchClipse()
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }

        Item {
            width: eyeDropperIcon.implicitWidth
            height: eyeDropperIcon.implicitHeight
            Text {
                id: eyeDropperIcon
                text: ""
                font.family: Fonts.monoFont
                font.pointSize: root.iconSize
                font.bold: true
                color: Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.launchEyeDropper()
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }

        Item {
            id: miscIconWrapper
            width: miscIcon.implicitWidth
            height: miscIcon.implicitHeight
            Text {
                id: miscIcon
                text: ""
                font.family: Fonts.monoFont
                font.pointSize: root.iconSize
                font.bold: true
                color: Colors.text
                anchors.verticalCenter: parent.verticalCenter
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
            duration: Globals.anim.durations.small
            easing.type: Easing.InOutQuad
        }
    }

    //==================================================================

    function launchClipse() {
		clipse.running = true
	}

    Process {
		id: clipse
		command: ["sh", "-c", "foot -T 'ftui-Clipboard History' -e clipse"]
	}

    function launchEyeDropper() {
		eyeDropper.running = true
	}

    Process {
		id: eyeDropper
		command: ["sh", "-c", "~/.scripts/eyedropper.sh"]
	}

}
