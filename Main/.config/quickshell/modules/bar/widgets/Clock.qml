import QtQuick
import Quickshell
import Quickshell.Io
import "root:/data/"

Text {
    text: {
        let h = parseInt(DateTime.hours);
        let m = DateTime.minutes;
        let period = "AM";
        if (h >= 12) {
            period = "PM";
            if (h > 12)
                h -= 12;

        } else if (h === 0) {
            h = 12;
        }
        // Pad minutes if needed
        if (m.length === 1)
            m = "0" + m;

        return h + ":" + m + " " + period;
    }
    color: Colors.text
    font.family: Fonts.normalFont
    font.pointSize: 11
    font.bold: true
}
