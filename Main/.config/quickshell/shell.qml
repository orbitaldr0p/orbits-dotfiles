//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import qs.modules.bar
import qs.modules.background
import qs.modules.popups
import qs.modules.popups.media

ShellRoot {
    id: root
    property bool enableBar: true
    property bool enableBG: true
    property bool enablePopups: true
    property bool enableReload: true

    LazyLoader {
        active: root.enableBar
        component: Bar {}
    }
    LazyLoader {
        active: root.enableBG
        component: BackgroundImageLoader {}
    }
    LazyLoader {
        active: root.enablePopups
        component: MediaControls {}
    }
    LazyLoader {
        active: root.enablePopups
        component: CPUPopup {}
    }
    LazyLoader {
        active: root.enablePopups
        component: BatteryPopup {}
    }
    LazyLoader {
        active: root.enableReload
        component: ReloadPopup {}
    }
}
