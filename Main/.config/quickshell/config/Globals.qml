pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property Anim anim: Anim {}
    readonly property url wallDirectory: "root:/assets/wallpapers/"
    readonly property string wallpaper: "Stellar-colorized.png"

    component AnimCurves: QtObject {
        readonly property list<real> bg: [0.23, 1, 0.61, 1, 1, 1]
        readonly property list<real> slideout: [0.23, 1, 0.61, 1, 1, 1]
    }

    component AnimDurations: QtObject {
        readonly property int small: 200
        readonly property int normal: 400
        readonly property int large: 600
        readonly property int extraLarge: 1000
        readonly property int bg: 570
        readonly property int workspace: 50
    }

    component Anim: QtObject {
        readonly property AnimCurves curves: AnimCurves {}
        readonly property AnimDurations durations: AnimDurations {}
    }
}
