import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

RowLayout {
	Repeater {
		model: SystemTray.items

		IconImage {
			required property SystemTrayItem modelData

			source: modelData.icon
			implicitSize: 20
		}
	}
}
