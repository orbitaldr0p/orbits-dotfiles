//@ pragma UseQApplication
import Quickshell
import Quickshell.Wayland
import "modules"
import "modules/bar"

ShellRoot {
    Bar {}

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
