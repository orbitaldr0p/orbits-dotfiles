pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import qs.data
import qs.common
import qs.config

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
