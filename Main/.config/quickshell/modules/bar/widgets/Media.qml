pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config

Item {
    id: root
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property string title: activePlayer ? StringUtils.cleanMusicTitle(activePlayer?.trackTitle) || (Globals.mediaHide ? "No media" : "") : (Globals.mediaHide ? "No media" : "")
    readonly property string artist: activePlayer ? activePlayer.trackArtist || "" : ""
    property bool hovered: false
    property bool popupLoaded: false

    Layout.preferredWidth: hovered || popupLoaded || !Globals.mediaHide ? mediaRow.width : mediaIcon.width
    Layout.preferredHeight: mediaRow.height
    clip: true

    Timer {
        running: root.activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: root.activePlayer.positionChanged()
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            switch (mouse.button) {
            case Qt.LeftButton:
                Hyprland.dispatch("global quickshell:mediaControlsToggle");
                root.popupLoaded = !root.popupLoaded;
                break;
            case Qt.MiddleButton:
                root.activePlayer.togglePlaying();
                break;
            }
        }

        hoverEnabled: true
        onEntered: root.hovered = true
        onExited: root.hovered = false
    }

    Row {
        id: mediaRow
        spacing: parent.parent.height / 4
        Layout.alignment: Qt.AlignVCenter

        CircularProgress {
            id: mediaIcon
            lineWidth: 2
            value: root.activePlayer?.position / root.activePlayer?.length
            size: 26
            Text {
                text: root.activePlayer?.isPlaying ? "  " : "  "
                font.family: Fonts.monoFont
                font.pointSize: 18
                font.bold: true
                color: Colors.text
                anchors.centerIn: parent
            }
        }

        Marquee {
            text: `${root.title}${Globals.mediaHide && root.artist ? ' - ' + root.artist : ''}`
            maxWidth: Globals.mediaHide ? 200 : 150
            anchors.verticalCenter: parent.verticalCenter
            scrollRate: 15
            pauseDuration: Globals.anim.durations.extraLarge * 1.5
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.normal
            easing.bezierCurve: Globals.anim.curves.slideout
            easing.type: Easing.BezierSpline
        }
    }
}
