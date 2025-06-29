// Stolen from end-4

import QtQuick
import "root:/data/"
import "root:/common/"
import "root:/config/"


Item {
    id: root

    property int size: 30
    property int lineWidth: 2
    property real value: 0
    property color primaryColor: Colors.text
    property color secondaryColor: Colors.withAlpha(Colors.text, 0.5)
    property real gapAngle: Math.PI / 10
    property bool fill: false
    property int fillOverflow: 2
    property int animationDuration: 1000
    property var easingType: Easing.OutCubic

    width: size
    height: size

    signal animationFinished

    Behavior on primaryColor {
        ColorAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    Behavior on secondaryColor {
        ColorAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }

    onValueChanged: {
        canvas.degree = value * 360;
    }
    onPrimaryColorChanged: {
        canvas.requestPaint();
    }
    onSecondaryColorChanged: {
        canvas.requestPaint();
    }

    Canvas {
        id: canvas

        property real degree: 0

        anchors.fill: parent
        antialiasing: true

        onDegreeChanged: {
            requestPaint();
        }

        onPaint: {
            var ctx = getContext("2d");
            var x = root.width / 2;
            var y = root.height / 2;
            var radius = root.size / 2 - root.lineWidth;
            var startAngle = (Math.PI / 180) * 270;
            var fullAngle = (Math.PI / 180) * (270 + 360);
            var progressAngle = (Math.PI / 180) * (270 + degree);
            var epsilon = 0.01; // Small angle in radians

            ctx.reset();
            if (root.fill) {
                ctx.fillStyle = root.secondaryColor;
                ctx.beginPath();
                ctx.arc(x, y, radius + fillOverflow, startAngle, fullAngle);
                ctx.fill();
            }
            ctx.lineCap = 'round';
            ctx.lineWidth = root.lineWidth;

            // Secondary
            ctx.beginPath();
            ctx.arc(x, y, radius, progressAngle + gapAngle, fullAngle - gapAngle);
            ctx.strokeStyle = root.secondaryColor;
            ctx.stroke();

            // Primary (value indication)
            var endAngle = progressAngle + (value > 0 ? 0 : epsilon);
            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, endAngle);
            ctx.strokeStyle = root.primaryColor;
            ctx.stroke();
        }

        Behavior on degree {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: root.easingType
            }
        }
    }
}
