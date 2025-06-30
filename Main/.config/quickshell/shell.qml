//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import "modules/bar"
import "modules/background"
import "modules/popups/media"

ShellRoot {
	property bool enableBar: true
	property bool enableBG: true
	property bool enableMedia: false

    LazyLoader { active: enableBar; component: Bar {} }
	LazyLoader { active: enableBG; component: BackgroundImageLoader {} }
	LazyLoader { active: enableMedia; component: MediaControls {} }
}
