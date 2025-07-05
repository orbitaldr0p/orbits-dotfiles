import QtQuick
import "root:/data/"
import "root:/common/"
import "root:/config/"

Item {
    id: root

    property string text: ""
    property var font: Fonts.monoFont
    property int size: 11
    property var color: Colors.text
    property int scrollRate: 5
    property int maxWidth: 100
    property int pauseDuration: Globals.anim.durations.normal

    clip: true
    width: Math.min(maxWidth, text1.paintedWidth)

    Text {
        id: text1
        text: " " + root.text
        font.family: root.font
        font.pointSize: root.size
        color: root.color
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: text2
        text: " " + root.text
        font.family: root.font
        font.pointSize: root.size
        color: root.color
        anchors.verticalCenter: parent.verticalCenter
    }

    SequentialAnimation {
        id: scrollAnim
        loops: Animation.Infinite

        PauseAnimation {
            duration: root.pauseDuration
        }

        NumberAnimation {
            target: text1
            property: "x"
            from: 0
            to: -text1.paintedWidth
            duration: text1.paintedWidth * root.scrollRate
            easing.type: Easing.Linear
        }

        ScriptAction {
            script: {
                text1.x = 0;
                text2.x = text1.paintedWidth;
            }
        }
    }

    Connections {
        target: text1
        onXChanged: {
            text2.x = text1.x + text1.paintedWidth;
        }
    }

    function restartAnimation() {
        scrollAnim.stop();
        text1.x = 0;
        text2.x = text1.paintedWidth;
        scrollAnim.start();
    }

    Component.onCompleted: restartAnimation()
    onTextChanged: restartAnimation()
    onWidthChanged: restartAnimation()
}
