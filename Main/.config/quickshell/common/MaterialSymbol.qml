// Stolen from end-4

import QtQuick
import "root:/data/"
import "root:/common/"
import "root:/config/"

Text {
    id: root
    property real iconSize: 16
    property real fill: 0
    property real truncatedFill: Math.round(fill * 100) / 100
    renderType: Text.NativeRendering
    font {
        hintingPreference: Font.PreferFullHinting
        family: "Material Symbols Rounded"
        pixelSize: iconSize
        weight: Font.Normal + (Font.DemiBold - Font.Normal) * fill
        variableAxes: {
            "FILL": truncatedFill,
            // "wght": font.weight,
            // "GRAD": 0,
            "opsz": iconSize
        }
    }
    verticalAlignment: Text.AlignVCenter
    color: Colors.text
}
