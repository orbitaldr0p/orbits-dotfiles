pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import "root:/data/"
import "root:/common/"
import "root:/config/"


Item {
	id: root
	readonly property MprisPlayer activePlayer: MprisController.activePlayer
	readonly property string title: activePlayer ? activePlayer.trackTitle || "No media" : "No media"
    readonly property string artist: activePlayer ? activePlayer.trackArtist || "" : ""
    property bool hovered: false

	Layout.preferredWidth: hovered ? mediaRow.width : mediaIcon.width
	Layout.preferredHeight: mediaRow.height
    clip: true

	Timer {
		running: activePlayer ?. playbackState == MprisPlaybackState.Playing
		interval: 1000
		repeat: true
		onTriggered: activePlayer.positionChanged()
	}

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            switch (mouse.button) {
                case Qt.LeftButton:
                    Hyprland.dispatch("global quickshell:mediaControlsToggle")
                    break;
                case Qt.MiddleButton:
                    activePlayer.togglePlaying();
                    break;
            }
        }

        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
    }

    Row {
        id: mediaRow
		spacing: parent.parent.height/4
		Layout.alignment: Qt.AlignVCenter

        CircularProgress {
            id: mediaIcon
            lineWidth: 2
            value: activePlayer?.position / activePlayer?.length
            size: 26
            Text {
				text: activePlayer?.isPlaying ? "  ": "  "
				font.family: Fonts.monoFont
				font.pointSize: 18
				font.bold: true
				color: Colors.text
				anchors.centerIn: parent
			}
        }

        Rectangle {
            id: mediaTextContainer
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter
            implicitWidth: Math.min(200, mediaText.implicitWidth)
            height: parent.height
            color: "transparent"
            Text {
                id: mediaText
                text: `${title}${artist ? ' - ' + artist: ''}`
                font.family: Fonts.monoFont
                font.pointSize: 11
                font.bold: false
                color: Colors.text
                elide: Text.ElideRight
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                clip: true
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
