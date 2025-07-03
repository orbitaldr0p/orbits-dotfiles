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
    property int pauseDuration: Globals.anim.durations.normal
    property int maxWidth: 100

    clip: true
    width: Math.min(maxWidth, animatedText.width)

    function originX() {
        var ret = root.width - animatedText.width;
        if (ret > 0)
            return ret / 2;
        else
            return 0;
    }

    function destinationX() {
        var ret = root.width - animatedText.width;
        if (ret < 0)
            return ret;
        else
            return originX();
    }

    function restartAnimation() {
        animation.stop();
        animation1.from = originX();
        animation1.to = originX();
        animation2.to = destinationX();
        animation.start();
    }

    onWidthChanged: restartAnimation()
    Text {
        id: animatedText
        width: contentWidth
        onWidthChanged: root.restartAnimation()
        elide: Text.ElideNone
        text: root.text
        font.family: root.font
        color: root.color
        font.pointSize: root.size
        anchors.verticalCenter: parent.verticalCenter
    }

    SequentialAnimation {
        id: animation
        loops: Animation.Infinite
        NumberAnimation {
            id: animation1
            target: animatedText
            property: "x"
            duration: root.pauseDuration
        }
        NumberAnimation {
            id: animation2
            target: animatedText
            property: "x"
            duration: animatedText.width * root.scrollRate
            easing.type: Easing.Linear
        }
        NumberAnimation {
            target: animatedText
            property: "x"
            duration: root.pauseDuration
        }
    }
}
