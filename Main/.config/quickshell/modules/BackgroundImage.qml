import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/data/"

Rectangle {
    height: Hyprland.focusedMonitor.height
    width: Hyprland.focusedMonitor.width
    color: Colors.surface ?? "black"
    property real scaleFactor: Hyprland.focusedMonitor.scale ?? 1.0

    Image {
        id: wallpaper
        source: "root:/assets/wallpapers/Stellar.jpg"
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        cache: true

        width: implicitWidth
        height: implicitHeight


        transformOrigin: Item.TopLeft
        scale: 1 / scaleFactor

        property int extraWidth: wallpaper.width - Hyprland.focusedMonitor.width
        property int wallpaper_x: - (Hyprland.focusedMonitor.activeWorkspace.id - 1) * extraWidth / 15

        x: wallpaper_x

        Behavior on x {
            NumberAnimation {
                duration: 570
                easing.bezierCurve: [0.23, 1, 0.61, 1, 1, 1]
                easing.type: Easing.BezierSpline
            }
        }
    }
}