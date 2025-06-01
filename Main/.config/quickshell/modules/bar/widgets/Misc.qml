import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import "root:/data/"

Rectangle {
    id: miscRoot
    property var iconSize: 17
    Layout.preferredWidth: miscRow.width
    Layout.preferredHeight: miscRow.height
    color: "transparent"

    Row {
        id: miscRow
        Layout.alignment: Qt.AlignVCenter
        spacing: 10

        Item {
            width: clipHistIcon.implicitWidth
            height: clipHistIcon.implicitHeight
            Text {
                id: clipHistIcon
                text: ""
                font.family: Fonts.monoFont
                font.pointSize: miscRoot.iconSize
                font.bold: true
                color: Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    miscRoot.launchClipse()
                }
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
                font.pointSize: miscRoot.iconSize
                font.bold: true
                color: Colors.text
                anchors.verticalCenter: parent.verticalCenter
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    miscRoot.launchEyeDropper()
                }
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
            }
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: 200
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
