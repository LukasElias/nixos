import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	spacing: 0

	Repeater {
		model: Hyprland.workspaces

		Rectangle {
			id: workspace
			required property HyprlandWorkspace modelData

			Layout.preferredWidth: 30
			Layout.fillHeight: true

			color: modelData.focused ? `#${Config.palette.base0B}` : `#${Config.palette.base08}`

			Text {
				text: workspace.modelData.id
				color: `#${Config.palette.base05}`
				font.pixelSize: 14

				anchors.centerIn: parent
			}

			MouseArea {
				anchors.fill: parent
				onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspace.modelData.id} })`)
			}
		}
	}
}
