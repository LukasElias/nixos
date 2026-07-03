import Quickshell.Networking

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	id: root

	property bool wifiEnabled: Networking.wifiEnabled
	property var devices: Networking.devices

	Repeater {
		model: root.devices

		RowLayout {
			id: device
			required property NetworkDevice modelData

			Text {
				text: DeviceType.toString(device.modelData.type)
				color: `#${Config.palette.base05}`
				font: Config.font
			}

			Repeater {
				model: device.modelData.networks

				Text {
					required property Network modelData

					text: modelData.name
					visible: modelData.connected

					color: `#${Config.palette.base05}`
					font: Config.font
				}
			}
		}
	}
}
