import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

RowLayout {
	spacing: 0

	Repeater {
		model: Hyprland.workspaces

		Rectangle {
			id: workspace
			required property HyprlandWorkspace modelData

			Layout.preferredWidth: 30
			Layout.fillHeight: true

			color: modelData.focused ? "#070" : "#700"

			Text {
				text: workspace.modelData.id
				color: "#fff"
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
