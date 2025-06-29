//@ pragma UseQApplication
import Quickshell
import "modules/bar"
import "modules/background"

ShellRoot {
	property bool enableBar: true
	property bool enableBG: true

    LazyLoader { active: enableBar; component: Bar {} }
	LazyLoader { active: enableBG; component: BackgroundImageLoader {} }
}
