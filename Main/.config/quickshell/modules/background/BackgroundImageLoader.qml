pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import "root:/data/"
import "root:/common/"
import "root:/config/"

Scope {
    id: bg
    PanelWindow {
        id: background
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background
        color: "transparent"
        anchors {
            top: true
            left: true
            right: true
            bottom: true
        }
        BackgroundImage {}
    }
}
