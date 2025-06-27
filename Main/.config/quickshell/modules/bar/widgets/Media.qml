import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Io
import Quickshell.Services.Mpris
import "root:/data/"
import "root:"

MouseArea {
    id: root
    readonly property MprisPlayer activePlayer: MprisController.activePlayer
    readonly property string title: activePlayer.trackTitle || qsTr("No media")
    readonly property string artist: activePlayer.trackArtist 

    Layout.preferredWidth: mediaRow.width
    height: parent.height

    Timer {
        running: activePlayer?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: activePlayer.positionChanged()
    }

    acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
    cursorShape: Qt.PointingHandCursor

    Row {
        id: mediaRow
        Layout.alignment: Qt.AlignVCenter
        height: parent.height
        spacing: 5

        Text {
            text: `${root.title}${artist ? ' - ' + artist : ''}`
            font.family: Fonts.monoFont
            font.pointSize: 11
            font.bold: false
            color: Colors.text
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.small
            easing.type: Easing.InOutQuad
        }
    }
}
