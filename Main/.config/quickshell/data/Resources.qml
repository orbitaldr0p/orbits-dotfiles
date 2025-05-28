import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    property real cpuPercent
    property string memUsed
    property list<real> cpuCoresPercent

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
        command: ["sh", "-c", "free -h | awk 'NR==2{print $3}'"]

        stdout: SplitParser {
            onRead: (data) => {
                return memUsed = data;
            }
        }

    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: () => {
            processCpuPercent.running = true;
            processCpuCoresPercent.running = true;
            processMemUsed.running = true;
        }
    }

}
