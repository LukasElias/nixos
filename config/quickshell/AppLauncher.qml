import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import "config.js" as Config

// PanelWindow
// ListView
// SearchBar
// Launch app

Scope {
	id: root
	property bool launcherOpen: false

	IpcHandler {
		target: "launcher"

		function toggle(): void {
			root.launcherOpen = !root.launcherOpen
			if (root.launcherOpen) {
				searchInput.text = ""
				selectedIndex = 0
				searchInput.forceActiveFocus()
			}
		}
	}

	property list<DesktopEntry> allItems: DesktopEntries.applications.values
	property int selectedIndex: 0

	ScriptModel {
		id: filteredItems

		objectProp: "id"
		values: {
			const all = [...root.allItems];

			const query = searchInput.text;

			if (query === "") return all.sort((a, b) => a.name.localeCompare(b.name));

			// const filtered = all
				// .filter(item =>
				// 	(item.name && item.name.toLowerCase().includes(query)) ||
				// 	(item.genericName && item.genericName.toLowerCase().includes(query)) ||
				// 	(item.keywords && item.keywords.some(k => k.toLowerCase().includes(query))) ||
				// 	(item.categories && item.categories.some(c => c.toLowerCase().includes(query)))
				// )
			// ;

			// const sorted = filtered
				// .sort((a, b) => {
				// 	const aName = a.name.toLowerCase();
				// 	const bName = b.name.toLowerCase();
				// 	const aStarts = aName.startsWith(query);
				// 	const bStarts = bName.startsWith(query);
				// 	if (aStarts && !bStarts) return -1;
				// 	if (!aStarts && bStarts) return 1;
				// 	return aName.localeCompare(bName);
				// })
			// ;

			return all;
		}
	}

	function launchApp(entry) {
		entry.execute();
		root.launcherOpen = false;
	}

	PanelWindow {
		id: launcherOpen
		visible: root.launcherOpen
		focusable: true
		color: "transparent"
		exclusionMode: ExclusionMode.Ignore

		WlrLayershell.layer: WlrLayer.Overlay
		WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

		anchors {
			top: true
			bottom: true
			left: true
			right: true
		}

		Rectangle {
			anchors.centerIn: parent
			width: 580 // todo: config.js
			height: 480
			radius: 16
			// color: `#${Config.palette.base00}`
			color: "red"

			ColumnLayout {
				TextInput {
					id: searchInput
					font: Config.font

					Layout.fillWidth: true
					Layout.alignment: Qt.AlignVCenter

					color: `#${Config.palette.base05}`
					clip: true
					focus: true

					Accessible.role: Accessible.EditableText
					Accessible.name: "Search applications"

					onTextChanged: root.selectedIndex = 0

					Keys.onEscapePressed: root.launcherOpen = false

					Keys.onPressed: event => {
						if (event.key === Qt.Key_Down) {
							event.accepted = true;
							root.selectedIndex = Math.min(root.selectedIndex + 1, resultsList.count - 1);
							resultsList.positionViewAtIndex(root.selectedIndex, ListView.Contain);
						} else if (event.key === Qt.Key_Up) {
							event.accepted = true;
							root.selectedIndex = Math.max(root.selectedIndex - 1, 0);
							resultsList.positionViewAtIndex(root.selectedIndex, ListView.Contain);
						} else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
							event.accepted = true;
							if (root.selectedIndex >= 0) {
								const entry = root.filteredItems[root.selectedIndex];
								if (entry) root.launchApp(entry);
							}
						} else if (event.key === Qt.Key_Tab) {
							event.accepted = true;
							root.selectedIndex = Math.min(root.selectedIndex + 1, resultsList.count - 1);
							resultsList.positionViewAtIndex(root.selectedIndex, ListView.Contain);
						}
					}
				}

				ListView {
					id: resultsList
					Layout.fillWidth: true
					Layout.fillHeight: true
					model: filteredItems
					clip: true
					spacing: 2
					boundsBehavior: Flickable.StopAtBounds
					currentIndex: root.selectedIndex
					highlightMoveDuration: 150
					highlightMoveVelocity: -1

					highlight: Rectangle {
						radius: 8
						color: `#${Config.palette.base02}`
						visible: root.selectedIndex >= 0

						Rectangle {
							width: 3
							height: 24
							radius: 2
							color: `#${Config.palette.base08}`
							anchors.left: parent.left
							anchors.leftMargin: 2
							anchors.verticalCenter: parent.verticalCenter
						}
					}

					delegate: Rectangle {
						id: delegateRoot
						required property var modelData
						required property int index

						Accessible.role: Accessible.Button
						Accessible.name: (modelData.name ?? "Application") + (modelData.genericName ? " - " + modelData.genericName : "")

						width: resultsList.width
						height: 44
						radius: 8
						color: "transparent"

						RowLayout {
							anchors.fill: parent
							anchors.leftMargin: 12
							anchors.rightMargin: 12
							spacing: 12

							// App icon
							Item {
								width: 28
								height: 28
								Layout.alignment: Qt.AlignVCenter

								IconImage {
									anchors.fill: parent
									source: Quickshell.iconPath(delegateRoot.modelData.icon ?? "", true)
									visible: (delegateRoot.modelData.icon ?? "") !== ""
								}

								// Fallback icon
								Text {
									anchors.centerIn: parent
									text: ""
									color: "yellow"
									font: Config.font
									visible: (delegateRoot.modelData.icon ?? "") === ""
								}
							}

							// App info
							ColumnLayout {
								Layout.fillWidth: true
								Layout.alignment: Qt.AlignVCenter
								spacing: 1

								Text {
									text: delegateRoot.modelData.name ?? ""
									color: root.selectedIndex === delegateRoot.index ? "orange" : "blue"
									font: Config.font
									elide: Text.ElideRight
									Layout.fillWidth: true
								}

								Text {
									text: delegateRoot.modelData.genericName ?? delegateRoot.modelData.comment ?? ""
									color: "blue"
									font: Config.font
									elide: Text.ElideRight
									Layout.fillWidth: true
									visible: text !== ""
								}
							}
						}

						MouseArea {
							anchors.fill: parent
							hoverEnabled: true
							cursorShape: Qt.PointingHandCursor
							onClicked: root.launchApp(delegateRoot.modelData)
							onPositionChanged: root.selectedIndex = delegateRoot.index
						}
					}

					// Empty state
					// Text {
					// 	anchors.centerIn: parent
					// 	text: "	No applications found"
					// 	color: root.theme.textMuted
					// 	font.pixelSize: 14
					// 	font.family: root.font
					// 	visible: resultsList.count === 0 && searchInput.text !== ""
					// }
				}
			}
		}
	}
}
