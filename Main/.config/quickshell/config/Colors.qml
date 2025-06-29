import QtQuick
import Quickshell
pragma Singleton

Singleton {
    property color rosewater: "#f2d5cf"
    property color flamingo:  "#eebebe"
    property color pink:      "#f4b8e4"
    property color mauve:     "#ca9ee6"
    property color red:       "#e78284"
    property color maroon:    "#ea999c"
    property color peach:     "#ef9f76"
    property color yellow:    "#e5c890"
    property color green:     "#a6d189"
    property color teal:      "#81c8be"
    property color sky:       "#99d1db"
    property color sapphire:  "#85c1dc"
    property color blue:      "#8caaee"
    property color lavender:  "#babbf1"
    // Greys
    property color text:      "#c6d0f5"
    property color subtext1:  "#b5bfe2"
    property color subtext0:  "#a5adce"
    property color overlay2:  "#949cbb"
    property color overlay1:  "#838ba7"
    property color overlay0:  "#737994"
    property color surface2:  "#626880"
    property color surface1:  "#51576d"
    property color surface0:  "#414559"
    property color base:      "#303446"
    property color mantle:    "#292c3c"
    property color crust:     "#232634"

    function withAlpha(c, a) {
        let color = Qt.color(c);
        return Qt.rgba(color.r, color.g, color.b, a);
    }
}
