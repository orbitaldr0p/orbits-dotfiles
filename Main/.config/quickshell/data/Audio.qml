import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Io
pragma Singleton

Singleton {
	id : root
	property PwNode sink : Pipewire.defaultAudioSink
	property PwNode source : Pipewire.defaultAudioSource
	property var volume: sink ?.audio.volume
	property var muted: sink ?.audio.muted

	property var micMuted: source ?.audio.muted
	property var micVolume: source ?.audio.volume
	property string volIcon : {
		(muted) ? "󰝟" : (volume > 0.66) ? "󰕾" : (volume > 0.01) ? "󰖀" : "󰕿"
	}
	PwObjectTracker {
		objects : [root.sink, root.source]
	}
	function launchAudioManagement() {
		audioCol.running = true
	}
	function increase() {
		audioInc.running = true
	}
	function decrease() {
		audioDec.running = true
	}
	function mute() {
		audioMut.running = true
	}
	function micMute() {
		audioMicMut.running = true
	}

	Process {
		id : audioCol
		command : ["sh", "-c", "pwvucontrol"]
	}
	Process {
		id : audioInc
		command : ["sh", "-c", "~/.scripts/System/volumeControl.sh i"]
	}
	Process {
		id : audioDec
		command : ["sh", "-c", "~/.scripts/System/volumeControl.sh d"]
	}
	Process {
		id : audioMut
		command : ["sh", "-c", "~/.scripts/System/volumeControl.sh m"]
	}
	Process {
		id : audioMicMut
		command : ["sh", "-c", "~/.scripts/System/volumeControl.sh mm"]
	}
}
