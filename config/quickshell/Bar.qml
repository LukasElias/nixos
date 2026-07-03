import Quickshell

import QtQuick
import QtQuick.Layouts

import qs.Widgets

import "config.js" as Config

Scope {
	id: root
	property var modelData

	PanelWindow {
		id: window
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
			color: `#aa${Config.palette.base00}`

			RowLayout {
				anchors {
					left: parent.left
					top: parent.top
					bottom: parent.bottom
				}

				Workspaces {}

				Splitter {}

				Tray {
					window: window
				}

				Splitter {}

				Audio {}

				Splitter {}

				Mpris {}
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

				Bluetooth {}

				Splitter {}

				Network {}

				Splitter {}

				Battery {}

				Splitter {}

				Hardware {}
			}
		}
	}
}
