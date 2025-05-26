import QtQuick
import Quickshell
import Quickshell.Io
pragma Singleton

Singleton {
    property string time

    Process {
        id: dateProc

        command: ["date"]
        running: true

        stdout: SplitParser {
            onRead: (data) => {
                return time = data;
            }
        }

    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }

}
