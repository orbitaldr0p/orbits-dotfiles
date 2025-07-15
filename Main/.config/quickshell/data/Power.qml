pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Io

Singleton {
    id: root
    readonly property var battery: UPower.displayDevice
    readonly property var chargeState: battery.state
    readonly property bool isCharging: chargeState == UPowerDeviceState.Charging
    readonly property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    readonly property var batPercent: battery.percentage
	readonly property string batIcon: {
		(isCharging) ? "󰂄"
		: (batPercent == 1) ? "󰁹"
		: (batPercent >= 0.9) ? "󰂂"
		: (batPercent >= 0.8) ? "󰂁"
		: (batPercent >= 0.7) ? "󰂀"
		: (batPercent >= 0.6) ? "󰁿"
		: (batPercent >= 0.5) ? "󰁾"
		: (batPercent >= 0.4) ? "󰁽"
		: (batPercent >= 0.3) ? "󰁼"
		: (batPercent >= 0.2) ? "󰁻"
		: (batPercent >= 0.1) ? "󰁺"
		: "󰂃"
	}

    function batteryMonitor() {
        batMon.running = true;
    }
    function changePowerProfile() {
        pwrProf.running = true;
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
