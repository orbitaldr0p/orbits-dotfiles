import Quickshell;
import Quickshell.Io;
import QtQuick;
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    id: root
    property string networkName: "";
    property int networkStrength;
    property bool networkDisabled
    property string netIcon : {
		(networkDisabled) ? "󰤮" : (networkStrength > 75) ? "󰤨" : (volume > 0.5) ? "󰤥" : (volume > 0.25) ? "󰤢" : "󰤟"
	}

    Process {
        id: updateNetworkName
        command: ["sh", "-c", "nmcli -t -f NAME c show --active | head -1"]
        running: true;
        stdout: SplitParser {
            onRead: data => {
                root.networkName = data
            }
        }
    }

    Process {
        id: updateNetworkStrength
        running: true
        command: ["sh", "-c", "nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/^\*/{if (NR!=1) {print $2}}'"];
        stdout: SplitParser {
            onRead: data => {
                root.networkStrength = parseInt(data);
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: () => {
            updateNetworkStrength.running = true;
            updateNetworkName.running = true;
        }
    }


    //===================================

    function launchWifiMenu() {
        wifiMenu.running = true
    }

    Process {
        id: wifiMenu
        command: ["sh", "-c", "network_manager"]
    }
}
