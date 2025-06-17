import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton
pragma ComponentBehavior: Bound

Singleton {
    property real cpuPercent
    property real cpuTemp
    property list<real> cpuCoresPercent
    property int lastCpuIdle
    property int lastCpuTotal
    property string memUsed
    property string memTotal
    property real memPercent: memTotal > 0 ? Math.round((memUsed / memTotal) * 100) : 0
	property string tempIcon : {
		(cpuTemp >= 90) ? "" 
		: (cpuTemp >= 80) ? "" 
		: (cpuTemp >= 60) ? "" 
		: (cpuTemp >= 40) ? "" 
		: (cpuTemp >= 20) ? "" 
		: ""
	}

/*     Process {
        id: processCpuPercent
        running: true
        command: ["sh", "-c", "top -bn1 | awk 'NR==3'"]
        stdout: SplitParser {
            onRead: (data) => {
                const idle = data.split(',')[3].trim().split(' ')[0];
                cpuPercent = Math.round(100 - idle);
            }
        }
    } */

    FileView {
        id: processCpuPercent

        path: "/proc/stat"
        onLoaded: {
            const data = text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (data) {
                const stats = data.slice(1).map(n => parseInt(n, 10));
                const total = stats.reduce((a, b) => a + b, 0);
                const idle = stats[3];

                const totalDiff = total - lastCpuTotal;
                const idleDiff = idle - lastCpuIdle;
                const perc = totalDiff > 0 ? (1 - idleDiff / totalDiff) * 100 : 0;

                cpuPercent = Math.round(perc)
                lastCpuTotal = total;
                lastCpuIdle = idle;
            }
        }
    }


    Process {
        id: processCpuTemp
        running: true
        command: ["fish", "-c", "cat /sys/class/thermal/thermal_zone*/temp | string join ' '"]
        stdout: SplitParser {
            onRead: data => {
                const temps = data.trim().split(" ");
                const sum = temps.reduce((acc, d) => acc + parseInt(d, 10), 0);
                cpuTemp = Math.round(sum / temps.length / 1000);
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
            processCpuPercent.reload();
            processCpuTemp.running = true;
            processCpuCoresPercent.running = true;
            processMemUsed.running = true;
            processMemTotal.running = true;
        }
    }

}
