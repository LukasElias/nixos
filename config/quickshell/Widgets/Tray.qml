import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

RowLayout {
	id: root
	required property PanelWindow window

	Repeater {
		model: SystemTray.items

		Rectangle {
			id: trayItem
			required property SystemTrayItem modelData

			color: "transparent"
			Layout.preferredWidth: 30
			Layout.fillHeight: true

			IconImage {
				anchors.fill: parent
				source: trayItem.modelData.icon
			}

			MouseArea {
				anchors.fill: parent
				acceptedButtons: Qt.LeftButton | Qt.RightButton

				onClicked: (mouse) => {
					if (mouse.button === Qt.LeftButton) {
						console.log("left")
						trayItem.modelData.activate()
					} else {
						console.log("right")
						trayItem.modelData.display(root.window, mouse.x, mouse.y)
					}
				}
			}
		}
	}
}
