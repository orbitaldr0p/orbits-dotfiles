pragma ComponentBehavior: Bound

import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Widgets
import Quickshell.Wayland
import "root:/data/"
import "root:/common/"
import "root:/config/"

Item {
    id: playerController
    required property MprisPlayer player
    property var artUrl: player?.trackArtUrl

    implicitWidth: widgetWidth
    implicitHeight: widgetHeight
}

