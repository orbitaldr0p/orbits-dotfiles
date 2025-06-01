import QtQuick
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Io
pragma Singleton


Singleton {
	id: root
	property var battery: UPower.displayDevice
	property var chargeState: battery.state
	property bool isCharging: chargeState == UPowerDeviceState.Charging
	property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
	property var batPercent: battery.percentage
	property string batIcon: {
		(isCharging) ? "󰂄": (batPercent == 1) ? "󰁹": (batPercent >= 0.9) ? "󰂂": (batPercent >= 0.8) ? "󰂁": (batPercent >= 0.7) ? "󰂀": (batPercent >= 0.6) ? "󰁿": (batPercent >= 0.5) ? "󰁾": (batPercent >= 0.4) ? "󰁽": (batPercent >= 0.3) ? "󰁼": (batPercent >= 0.2) ? "󰁻": (batPercent >= 0.1) ? "󰁺": "󰂃"
	}

	function batteryMonitor() {
		batMon.running = true
	}
	function changePowerProfile() {
		pwrProf.running = true
	}
	Process {
		id: batMon
		command: ["sh", "-c", "foot -T 'ftui-Battery Status' -e battop"]
	}

    Process {
		id: pwrProf
		command: ["sh", "-c", "~/.scripts/System/powerProfile.sh"]
	}
}
