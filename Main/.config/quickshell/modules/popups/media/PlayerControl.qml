pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import Quickshell.Services.Mpris
import Quickshell.Hyprland
import qs.data
import qs.common
import qs.config

Item {
    id: playerController
    required property MprisPlayer player
    property var artUrl: player?.trackArtUrl
    property string albumArt

    implicitWidth: 400
    implicitHeight: 130

    Process {
        id: albumArtProc
        command: ["/bin/sh", "-c", "playerctl metadata --format '{{mpris:artUrl}}'"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                playerController.albumArt = data;
            }
        }
    }

    Timer {
        running: playerController.player?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            playerController.player.positionChanged();
        }
    }

    Rectangle {
        id: playerControllerRect
        anchors.fill: parent
        radius: 5
        color: Colors.withAlpha(Colors.base, 0.5)

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15

            Rectangle {
                id: artBackground
                height: 100
                width: 100
                radius: 5
                color: "transparent"
                anchors.verticalCenter: parent.verticalCenter
                clip: true

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: artBackground.width
                        height: artBackground.height
                        radius: artBackground.radius
                    }
                }

                Image {
                    property int size: parent.height
                    anchors.fill: parent
                    source: albumArt
                    fillMode: Image.PreserveAspectCrop
                }
            }

            ColumnLayout {
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

                Text {
                    // Track Time
                    id: trackTime
                    text: StringUtils.timeConverter(playerController.player?.position) + " / " + StringUtils.timeConverter(playerController.player?.length)
                    color: Colors.text
                    font.family: Fonts.normalFont
                    font.pointSize: 10
                }

                Rectangle {
                    //Progress Bar
                    id: progressBar
                    width: 250
                    height: 7
                    radius: 7
                    color: Colors.withAlpha(Colors.text, 0.2)
                    Rectangle {
                        id: progressRect
                        width: parent.width * (playerController.player?.position / playerController.player?.length)
                        height: parent.height
                        radius: parent.radius
                        color: Colors.text
                        Behavior on width {
                            NumberAnimation {
                                duration: 1000
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                    MouseArea {
                        focus: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            const jump = (mouse.x - progressRect.width)/progressBar.width * playerController.player?.length
                            //console.log(jump)
                            playerController.player.seek(jump)
                        }
                    }
                }

                Row {
                    id: controls
                    spacing: 5
                    Layout.alignment: Qt.AlignHCenter

                    Button {
                        id: skipPrevious
                        height: 40
                        width: 40
                        background: Rectangle {
                            color: "transparent"
                        }
                        MaterialSymbol {
                            id: skipPreviousIcon
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: "skip_previous"
                            iconSize: 40
                        }
                        onClicked: () => {
                            playerController.player.previous()
                        }
                    }
                    Button {
                        height: 40
                        width: 40
                        id: playPause
                        background: Rectangle {
                            color: "transparent"
                        }
                        MaterialSymbol {
                            id: playPauseIcon
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: playerController.player?.isPlaying ? "pause" : "play_arrow"
                            iconSize: 40
                        }
                        onClicked: {
                            playerController.player.togglePlaying()
                        }
                    }
                    Button {
                        id: skipNext
                        height: 40
                        width: 40
                        background: Rectangle {
                            color: "transparent"
                        }
                        MaterialSymbol {
                            id: skipNextIcon
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: "skip_next"
                            iconSize: 40
                        }
                        onClicked: () => {
                            playerController.player.next()
                        }
                    }
                }
            }
        }
    }
}
