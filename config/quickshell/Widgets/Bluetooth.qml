import Quickshell.Bluetooth

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	spacing: 10

	Repeater {
		model: Bluetooth.adapters

		RowLayout {
			id: adapter
			required property BluetoothAdapter modelData

			// Adapter info
			// Text {
			// 	text: adapter.modelData.enabled
			// 	color: "blue"
			// 	font: Config.font
			// }

			// Devices
			Repeater {
				model: adapter.modelData.devices

				Text {
					id: device
					required property BluetoothDevice modelData

					visible: modelData.connected

					text: modelData.name
					color: `#${Config.palette.base05}`
					font: Config.font
				}
			}
		}
	}
}
