import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root

	property PwNode sink: Pipewire.defaultAudioSink

	readonly property bool ready: sink && sink.ready
	readonly property bool muted: ready && sink.audio.muted
	readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0

	Text {
		text: {
			if (!root.ready) return "-"
			if (root.muted) return "muted"
			
			return root.volume + "%"
		}
		color: "red"
	}

	PwObjectTracker {
		objects: [root.sink]
	}
}
