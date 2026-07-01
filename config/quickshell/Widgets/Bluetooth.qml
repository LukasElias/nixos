import Quickshell.Bluetooth

import QtQuick
import QtQuick.Layouts

RowLayout {
	spacing: 10

	Repeater {
		model: Bluetooth.adapters

		RowLayout {
			id: adapter
			required property BluetoothAdapter modelData

			// Adapter info
			Text {
				text: adapter.modelData.enabled
				color: "blue"
			}

			// Devices
			Repeater {
				model: adapter.modelData.devices

				Text {
					id: device
					required property BluetoothDevice modelData

					visible: modelData.connected

					text: modelData.name
					color: "red"
				}
			}
		}
	}
}
