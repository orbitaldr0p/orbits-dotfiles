pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config

Item {
    id: playerController
    required property MprisPlayer player
    property var artUrl: player?.trackArtUrl

    implicitWidth: 400
    implicitHeight: 130

    Timer {
        running: playerController.player?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            playerController.player.positionChanged();
        }
    }


    Rectangle {
        anchors.fill: parent
        radius: 5
        color: Colors.withAlpha(Colors.base, 0.5)
        ColumnLayout {
            spacing: 2
            RowLayout {
                Rectangle {
                    id: artBackground
                    Layout.fillHeight: true
                    implicitWidth: height
                    radius: 5
                }
                ColumnLayout {
                    id: trackInfo
                    spacing: 2
                    Text {
                        id: trackTitle
                        text: playerController.player?.trackTitle || "Untitled"
                        color: Colors.text
                        font.family: Fonts.normalFont
                        font.pointSize: 13
                        font.bold: true
                    }
                    Text {
                        id: trackArtist
                        text: playerController.player?.trackArtist
                        color: Colors.text
                        font.family: Fonts.normalFont
                        font.pointSize: 10
                    }
                }
            }
            RowLayout {
                Text {
                    id: trackTime
                    text: StringUtils.timeConverter(playerController.player?.position) + "/" + StringUtils.timeConverter(playerController.player?.length)
                    color: Colors.text
                    font.family: Fonts.normalFont
                    font.pointSize: 13
                    font.bold: true
                }

            }
        }
    }
}
