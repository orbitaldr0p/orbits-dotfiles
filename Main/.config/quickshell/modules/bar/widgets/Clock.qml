pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "root:/data/"
import "root:/common/"
import "root:/config/"

Item {
    id: root
    property bool hovered: false
    Layout.preferredWidth: hovered ? timeRow.width : clockRow.width
    Layout.preferredHeight: timeRow.height
    clip: true

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
        // cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        onEntered: {
            root.hovered = true;
        }
        onExited: {
            root.hovered = false;
        }
    }

    Row {
        id: timeRow
        spacing: 10
        Layout.alignment: Qt.AlignVCenter
        Row {
            id: clockRow
            Text {
                id: clockText
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
        }
        Row {
            id: dateRow
            Text {
                id: dateText
                text: ` ${DateTime.day}-${DateTime.month}-${DateTime.year}  GMT${DateTime.timezone}`
                color: Colors.text
                font.family: Fonts.normalFont
                font.pointSize: 11
                font.bold: true
            }
        }
    }

    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Globals.anim.durations.normal
            easing.bezierCurve: Globals.anim.curves.bg
            easing.type: Easing.BezierSpline
        }
    }
}
