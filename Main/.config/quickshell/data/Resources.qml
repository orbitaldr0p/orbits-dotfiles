import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    property real cpuPercent
    property list<real> cpuCoresPercent
    property string memUsed
    property string memTotal
    property real memPercent: memTotal > 0 ? Math.round((memUsed / memTotal) * 100) : 0

    Process {
        id: processCpuPercent

        running: true
        command: ["sh", "-c", "top -bn1 | awk 'NR==3'"]

        stdout: SplitParser {
            onRead: (data) => {
                const idle = data.split(',')[3].trim().split(' ')[0];
                cpuPercent = Math.round(100 - idle);
            }
        }

    }

    Process {
        id: processCpuCoresPercent

        running: true
        command: ["sh", "-c", "mpstat -P ALL 1 1 | awk '/Average/ && $2 ~ /^[0-9]+$/ {print 100 - $12}' | paste -sd ','"]

        stdout: SplitParser {
            onRead: (data) => {
                return cpuCoresPercent = data.trim().split(",");
            }
        }

    }

    Process {
        id: processMemUsed

        running: true
        command: ["sh", "-c", "free -m | awk 'NR==2{print $3}'"]

        stdout: SplitParser {
            onRead: (data) => {
                return memUsed = data;
            }
        }

    }

    Process {
        id: processMemTotal

        running: true
        command: ["sh", "-c", "free -m | awk 'NR==2{print $2}'"]

        stdout: SplitParser {
            onRead: (data) => {
                return memTotal = data;
            }
        }

    }

    function systemMonitor() {
		sysMon.running = true
	}
	function gpuMonitor() {
		gpuMon.running = true
	}

    Process {
		id: sysMon
		command: ["sh", "-c", "foot -T 'ftui-System Monitor' -e btop"]
	}

    Process {
		id: gpuMon
		command: ["sh", "-c", "foot -T 'ftui-GPU Status' -e nvtop"]
	}

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: () => {
            processCpuPercent.running = true;
            // processCpuCoresPercent.running = true;
            processMemUsed.running = true;
            processMemTotal.running = true;
        }
    }

}
