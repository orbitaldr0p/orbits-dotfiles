pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Services.Mpris
import qs.data
import qs.common
import qs.config

Item {
    id: root
    required property MprisPlayer player
    property var artUrl: player?.trackArtUrl

    implicitWidth: 400
    implicitHeight: 130

    Timer {
        running: root.player?.playbackState == MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: {
            root.player.positionChanged();
        }
    }

    Rectangle {
        id: rootRect
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
                    source: root.artUrl
                    fillMode: Image.PreserveAspectCrop
                }
            }

            ColumnLayout {
                spacing: 2

                Marquee {
                    id: trackTitle
                    text: root.player?.trackTitle || "Untitled"
                    size: 13
                    maxWidth: 250
                    scrollRate: 15
                    pauseDuration: Globals.anim.durations.extraLarge * 1.5
                }

                Marquee {
                    id: trackArtist
                    text: root.player?.trackArtist || ""
                    size: 10
                    maxWidth: 250
                    scrollRate: 15
                    color: Colors.withAlpha(Colors.text, 0.7)
                    pauseDuration: Globals.anim.durations.extraLarge * 1.5
                }

                Text {
                    // Track Time
                    id: trackTime
                    text: StringUtils.timeConverter(root.player?.position) + " / " + StringUtils.timeConverter(root.player?.length)
                    color: Colors.withAlpha(Colors.text, 0.7)
                    font.family: Fonts.normalFont
                    font.pointSize: 10
                }

                Rectangle {
                    //Progress Bar
                    id: progressBar
                    Layout.preferredWidth: 250
                    Layout.preferredHeight: 7
                    radius: 7
                    color: Colors.withAlpha(Colors.text, 0.2)
                    Rectangle {
                        id: progressRect
                        width: parent.width * (root.player?.position / root.player?.length)
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
                            const ratio = mouse.x / progressBar.width;
                            const currentRatio = progressRect.width / progressBar.width;
                            const jump = (ratio - currentRatio) * (root.player?.length || 0);
                            root.player.seek(jump);
                        }
                    }
                }

                Row {
                    id: controls
                    spacing: 5
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        id: skipPrevious
                        property bool hovered: false

                        height: 40
                        width: 40
                        color: "transparent"
                        MaterialSymbol {
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: "skip_previous"
                            color: skipPrevious.hovered ? Colors.text : Colors.withAlpha(Colors.text, 0.5)
                            iconSize: 40
                            Behavior on color {
                                ColorAnimation {
                                    duration: Globals.anim.durations.small
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                skipPrevious.hovered = true;
                            }
                            onExited: {
                                skipPrevious.hovered = false;
                            }
                            onClicked: () => {
                                root.player.previous()
                            }
                        }
                    }
                    Rectangle {
                        id: playPause
                        property bool hovered: false

                        height: 40
                        width: 40
                        color: "transparent"
                        MaterialSymbol {
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: root.player?.isPlaying ? "pause" : "play_arrow"
                            color: playPause.hovered ? Colors.text : Colors.withAlpha(Colors.text, 0.5)
                            iconSize: 40
                            Behavior on color {
                                ColorAnimation {
                                    duration: Globals.anim.durations.small
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                playPause.hovered = true;
                            }
                            onExited: {
                                playPause.hovered = false;
                            }
                            onClicked: {
                                root.player.togglePlaying()
                            }
                        }
                    }
                    Rectangle {
                        id: skipNext
                        property bool hovered: false

                        height: 40
                        width: 40
                        color: "transparent"
                        MaterialSymbol {
                            anchors.centerIn: parent
                            anchors.fill: parent
                            text: "skip_next"
                            color: skipNext.hovered ? Colors.text : Colors.withAlpha(Colors.text, 0.5)
                            iconSize: 40
                            Behavior on color {
                                ColorAnimation {
                                    duration: Globals.anim.durations.small
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            hoverEnabled: true
                            onEntered: {
                                skipNext.hovered = true;
                            }
                            onExited: {
                                skipNext.hovered = false;
                            }
                            onClicked: () => {
                                root.player.next()
                            }
                        }
                    }
                }
            }
        }
    }
}
