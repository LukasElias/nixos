import Quickshell

import QtQuick
import QtQuick.Layouts

import "Widgets"

Scope {
	id: root
	property var modelData

	PanelWindow {
		screen: root.modelData

		anchors {
			top: true
			left: true
			right: true
		}

		implicitHeight: 30

		color: "transparent"

		Rectangle {
			anchors.fill: parent
			gradient: Gradient {
				GradientStop { position: 0.0; color: "#ff000000" }
				GradientStop { position: 0.8; color: "#66000000" }
				GradientStop { position: 1.0; color: "#00000000" }
			}

			RowLayout {
				anchors {
					left: parent.left
					top: parent.top
					bottom: parent.bottom
				}

				Workspaces {}

				Tray {}
			}

			RowLayout {
				anchors.centerIn: parent
				
				Clock {}
			}

			RowLayout {
				anchors {
					right: parent.right
					top: parent.top
					bottom: parent.bottom
				}

				Audio {}

				Mpris {}

				Bluetooth {}

				Network {}

				Battery {}

				Hardware {}
			}
		}
	}
}
