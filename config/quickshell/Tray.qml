import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

RowLayout {
	Repeater {
		model: SystemTray.items

		IconImage {
			required property SystemTrayItem modelData

			source: { console.log(modelData.icon); return modelData.icon }
			implicitSize: 20
		}
	}
}
