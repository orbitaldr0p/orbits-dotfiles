//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import "modules/bar"
import "modules/background"
import "modules/popups"
import "modules/popups/media"

ShellRoot {
    id: root
    property bool enableBar: true
    property bool enableBG: true
    property bool enableMedia: false
    property bool enablePopups: true

    LazyLoader {
        active: root.enableBar
        component: Bar {}
    }
    LazyLoader {
        active: root.enableBG
        component: BackgroundImageLoader {}
    }
    LazyLoader {
        active: root.enableMedia
        component: MediaControls {}
    }
    LazyLoader {
        active: root.enablePopups
        component: CPUPopup {}
    }
}
