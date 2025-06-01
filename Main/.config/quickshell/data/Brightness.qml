import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
	id : root
	property string deviceName : "intel_backlight"
	property string brightness
	property string brightnessMax
	property string brightnessPercent : brightness/brightnessMax
	property string brightnessIcon : {
		(brightnessPercent == 1) ? "" : (brightnessPercent >= 0.875) ? "" : (brightnessPercent >= 0.75) ? "" : (brightnessPercent >= 0.625) ? "" : (brightnessPercent >= 0.5) ? "" : (brightnessPercent >= 0.375) ? "" : (brightnessPercent >= 0.25) ? "" : (brightnessPercent >= 0.125) ? "" : ""
	}
	Component.onCompleted : {
		getBrightness.running = true 
		getBrightnessMax.running = true
	}

	function increase() {
		inc.running = true
		getBrightness.running = true
	}
	function decrease() {
		dec.running = true
		getBrightness.running = true
	}

	Process {
		id : getBrightness
		command : ["brightnessctl", "-d", "intel_backlight", "get"]
		stdout : SplitParser {
			onRead : data => {
				root.brightness = data
			}
		}
	}

	Process {
		id : getBrightnessMax
		command : ["brightnessctl", "-d", "intel_backlight", "max"]
		stdout : SplitParser {
			onRead : data => {
				root.brightnessMax = data
			}
		}
	}

	Process {
		id : inc
		command : ["sh", "-c", "~/.scripts/System/brightnessControl.sh i"]
	}

	Process {
		id : dec
		command : ["sh", "-c", "~/.scripts/System/brightnessControl.sh d"]
	}
}
