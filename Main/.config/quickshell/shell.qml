//@ pragma UseQApplication
import Quickshell
import "modules/bar"
import "modules/background"
import "modules/popups"

ShellRoot {
	property bool enableBar: true
	property bool enableBG: true
	property bool enableMedia: true

    LazyLoader { active: enableBar; component: Bar {} }
	LazyLoader { active: enableBG; component: BackgroundImageLoader {} }
}
