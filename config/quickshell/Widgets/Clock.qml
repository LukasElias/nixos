import Quickshell

import QtQuick

import "../config.js" as Config

Text {
	text: Qt.formatDateTime(clock.date, "hh:mm")
	color: `#${Config.palette.base05}`
	font.pixelSize: 14

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
