import Quickshell

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

					Workspaces {}

					Clock {}

					Audio {}

					// Spacer
					Item {
						Layout.fillWidth: true
					}
				}
			}
		}
	}
}
