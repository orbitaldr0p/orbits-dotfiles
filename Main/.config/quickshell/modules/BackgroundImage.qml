import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "root:/data/"

Rectangle {
	property int monitorWidth: Hyprland.focusedMonitor ? Hyprland.focusedMonitor.width: 0
	property int monitorHeight: Hyprland.focusedMonitor ? Hyprland.focusedMonitor.height: 0
	property real scaleFactor: Hyprland.focusedMonitor ? Hyprland.focusedMonitor.scale: 1.0
	property int activeWorkspaceId: (Hyprland.focusedMonitor && Hyprland.focusedMonitor.activeWorkspace) ? Hyprland.focusedMonitor.activeWorkspace.id: 1

	width: monitorWidth
	height: monitorHeight
	color: Colors.surface ?? "black"

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

		property int extraWidth: wallpaper.width - monitorWidth
		property int wallpaper_x: -(activeWorkspaceId - 1) * extraWidth / 15

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
