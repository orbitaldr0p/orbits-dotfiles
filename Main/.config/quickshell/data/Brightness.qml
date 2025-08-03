pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

Singleton {
    id: root
    property string deviceName: "intel_backlight"
    property string brightness
    property string brightnessMax
    property string brightnessPercent: brightness / brightnessMax
    property string brightnessIcon: {
        (brightnessPercent == 1) ? "" : (brightnessPercent >= 0.875) ? "" : (brightnessPercent >= 0.750) ? "" : (brightnessPercent >= 0.625) ? "" : (brightnessPercent >= 0.500) ? "" : (brightnessPercent >= 0.375) ? "" : (brightnessPercent >= 0.250) ? "" : (brightnessPercent >= 0.125) ? "" : "";
    }
    Component.onCompleted: {
        getBrightness.running = true;
        getBrightnessMax.running = true;
    }

    function increase() {
        inc.running = true;
    }
    function decrease() {
        dec.running = true;
    }

    Process {
        id: getBrightness
        command: ["brightnessctl", "-d", root.deviceName, "get"]
        stdout: SplitParser {
            onRead: data => {
                root.brightness = data;
            }
        }
    }

    Process {
        id: getBrightnessMax
        command: ["brightnessctl", "-d", root.deviceName, "max"]
        stdout: SplitParser {
            onRead: data => {
                root.brightnessMax = data;
            }
        }
    }

    Process {
        id: inc
        command: ["sh", "-c", "~/.scripts/System/brightnessControl.sh i"]
        onRunningChanged: {
            if (!running) {
                getBrightness.running = true;
            }
        }
    }

    Process {
        id: dec
        command: ["sh", "-c", "~/.scripts/System/brightnessControl.sh d"]
        onRunningChanged: {
            if (!running) {
                getBrightness.running = true;
            }
        }
    }

    IpcHandler {
        target: "getBrightness"
        function invoke(): void {
            getBrightness.running = true;
        }
    }

    GlobalShortcut {
        name: "getBrightnessActivator"
        description: qsTr("runs getBrightness process")
        onPressed: {
            getBrightness.running = true;
        }
    }
}
