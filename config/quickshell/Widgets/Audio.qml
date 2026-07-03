import Quickshell.Services.Pipewire

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	id: root

	property PwNode sink: Pipewire.defaultAudioSink

	readonly property bool ready: sink && sink.ready
	readonly property bool muted: ready && sink.audio.muted
	readonly property int volume: ready ? Math.round(sink.audio.volume * 100) : 0
	readonly property string icon: {
		if (!ready) return ""
		if (muted) return String.fromCodePoint(0xf075f)
		if (volume <= 10) return String.fromCodePoint(0xf057f)
		if (volume <= 40) return String.fromCodePoint(0xf0580)

		return String.fromCodePoint(0xf057e)
	}
	readonly property string text: {
		if (!ready) return "-"
		if (muted) return icon
		
		return `${icon} ${volume}%`
	}

	Text {
		text: root.text
		color: `#${Config.palette.base05}`
		font: Config.font
	}

	PwObjectTracker {
		objects: [root.sink]
	}
}
