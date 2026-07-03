import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	id: root

	property UPowerDevice displayDevice: UPower.displayDevice
	
	readonly property bool ready: displayDevice && displayDevice.ready
	readonly property int percentage: ready ? Math.round(displayDevice.percentage * 100) : 0
	readonly property string icon: {
		if (!ready) return
		if (percentage > 90) return String.fromCodePoint(0xf0079)

		return String.fromCodePoint(0xf007a + Math.max(0, Math.ceil(percentage / 10) - 1))

	}
	readonly property string text: {
		if (!ready) return "-"

		return `${icon} ${percentage}%`
	}

	Text {
		text: root.text
		color: `#${Config.palette.base0C}`
		font: Config.font
	}
}
