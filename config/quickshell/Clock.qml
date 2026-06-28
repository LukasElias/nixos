import Quickshell

import QtQuick

Text {
	text: Qt.formatDateTime(clock.date, "hh:mm")
	color: "#00f"
	font.pixelSize: 14

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
