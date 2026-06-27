import Quickshell
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

ShellRoot {
	id: root

	Variants {
		model: Quickshell.screens

		delegate: PanelWindow {
			property var modelData
			screen: modelData

			anchors {
				top: true
				left: true
				right: true
			}

			implicitHeight: 30

			Rectangle {
				anchors.fill: parent
				color: "black"

				RowLayout {
					anchors.fill: parent
					spacing: 0

					// Workspaces
					Repeater {
						model: Hyprland.workspaces

						Rectangle {
							id: workspace
							required property HyprlandWorkspace modelData

							Layout.preferredWidth: 30
							Layout.fillHeight: true

							color: Hyprland.focusedWorkspace.id == workspace.modelData.id ? "#070" : "#700"

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

					// Spacer
					Item {
						Layout.fillWidth: true
					}
				}
			}
		}
	}
}
