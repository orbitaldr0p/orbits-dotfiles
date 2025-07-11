pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    // Date components
    property string weekday
    property string month
    property string day
    property string timezone
    property string year
    // Time components
    property string hours
    property string minutes
    property string seconds

    Process {
        id: dateProc

        command: ["date"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                let parts = data.trim().split(/\s+/);
                if (parts.length >= 6) {
                    weekday = parts[0];
                    day = parts[1];
                    month = parts[2];
                    timezone = parts[4];
                    if (timezone.startsWith("+")) {
                        timezone = "UTC " + timezone;
                    }
                    year = parts[5];
                    let timeParts = parts[3].split(":");
                    if (timeParts.length === 3) {
                        hours = timeParts[0];
                        minutes = timeParts[1];
                        seconds = timeParts[2];
                    }
                }
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
