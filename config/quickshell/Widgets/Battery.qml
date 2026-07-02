import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	id: root

	property UPowerDevice displayDevice: UPower.displayDevice
	
	property bool ready: displayDevice && displayDevice.ready
	property int percentage: ready ? Math.round(displayDevice.percentage * 100) : 0

	Text {
		text: {
			if (root.percentage == 0) return "-"

			return root.percentage + "%"
		}
		color: `#${Config.palette.base0C}`
	}
}
