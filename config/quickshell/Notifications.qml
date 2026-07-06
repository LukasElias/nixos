import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Scope {
	id: root

	property bool notificationCenterOpen: false
	ListModel {
		id: history
	}

	NotificationServer {
		id: server

		bodySupported: true
		imageSupported: true
		actionsSupported: true

		onNotification: (notification) => {
			console.log("recieved notification: ", notification.summary, "---", notification.body);

			history.insert(0, {
				summary: notification.summary,
				body: notification.body,
				appName: notification.appName,
				urgency: notification.urgency,
				time: Qt.formatDateTime(new Date(), "hh:mm")
			});

			notification.tracked = true;
		}
	}

	IpcHandler {
		target: "notifications"

		function toggle() {
			root.notificationCenterOpen = !root.notificationCenterOpen
		}

		function open() {
			root.notificationCenterOpen = true
		}

		function close() {
			root.notificationCenterOpen = false
		}
	}

	PanelWindow {
		id: notificationCenter

		visible: root.notificationCenterOpen
		color: "transparent"

		exclusionMode: ExclusionMode.Ignore

		anchors {
			top: true
			right: true
		}

		margins {
			top: 42
			right: 12
		}

		implicitWidth: 380
		implicitHeight: centerColumn.implicitHeight + 24

		Rectangle {
			anchors.fill: parent
			radius: 8
			color: `#aa${Config.palette.base00}`
			border.width: 2
			border.color: `#${Config.palette.base0B}`

			ColumnLayout {
				id: centerColumn
				anchors.fill: parent
				anchors.margins: 12

				spacing: 10

				RowLayout {
					Layout.fillWidth: true
					Layout.preferredHeight: Config.font.pixelSize

					Text {
						Layout.fillWidth: true
						Layout.fillHeight: true

						text: "Notifications"
						color: `#${Config.palette.base05}`
						font: Config.font
					}

					Text {
						Layout.fillWidth: true
						Layout.fillHeight: true

						visible: history.count > 0
						text: "Clear all"
						color: `#${Config.palette.base08}`
						elide: Qt.ElideRight
						font: Config.font

						MouseArea {
							anchors.fill: parent

							onClicked: history.clear()
						}
					}
				}

				Repeater {
					model: history

					Rectangle {
						id: centerCard
						color: `#${Config.palette.base00}`

						required property var modelData
						required property int index

						Layout.fillWidth: true
						Layout.preferredHeight: cardLayout.implicitHeight + 20

						radius: 8

						border.width: 2
						border.color: `#${Config.palette.base0B}`

						ColumnLayout {
							id: cardLayout
							Layout.fillWidth: true

							anchors.fill: parent
							anchors.margins: 10

							RowLayout {
								Layout.fillWidth: true

								Text {
									Layout.fillWidth: true
									text: centerCard.modelData.summary
									color: `#${Config.palette.base0B}`
									font: Config.font

									visible: text !== ""
								}

								Text {
									Layout.fillWidth: true
									text: centerCard.modelData.time
									color: `#${Config.palette.base05}`

									font: Config.font

									elide: Qt.ElideRight
								}
							}

							Text {
								text: centerCard.modelData.body
								color: `#${Config.palette.base05}`
								font: Config.font

								wrapMode: Text.WrapAnywhere
							}
						}

						MouseArea {
							anchors.fill: parent

							onClicked: history.remove(centerCard.index)
						}
					}
				}
			}
		}
	}

	PanelWindow {
		id: notificationPopup
		color: "transparent"

		exclusionMode: ExclusionMode.Ignore

		anchors {
			top: true
			right: true
		}

		margins {
			top: 42
			right: 12
		}

		implicitWidth: 380
		implicitHeight: Math.max(1, popupColumn.implicitHeight)

		ColumnLayout {
			id: popupColumn
			anchors.fill: parent

			spacing: 10

			Repeater {
				model: server.trackedNotifications

				Rectangle {
					id: card

					color: `#${Config.palette.base00}`

					required property Notification modelData

					Layout.fillWidth: true
					Layout.preferredHeight: layout.implicitHeight + 20

					radius: 8

					border.width: 2
					border.color: `#${Config.palette.base0B}`

					Timer {
						running: card.modelData.urgency !== NotificationUrgency.Critical
						interval: Config.notifications.timeout
						onTriggered: card.modelData.dismiss()
					}

					RowLayout {
						id: layout

						spacing: 10

						Image {
							Layout.preferredWidth: 32
							Layout.preferredHeight: 32
							Layout.alignment: Qt.AlignTop
							fillMode: Image.PreserveAspectFit

							visible: source.toString !== ""
							source: card.modelData.image || card.modelData.appIcon || ""
						}

						ColumnLayout {
							Layout.fillWidth: true

							Text {
								text: card.modelData.summary
								color: `#${Config.palette.base0B}`
								font: Config.font

								visible: text !== ""
							}

							Text {
								text: card.modelData.body
								color: `#${Config.palette.base05}`
								font: Config.font

								wrapMode: Text.WrapAnywhere
							}
						}
					}

					MouseArea {
						anchors.fill: parent

						onClicked: card.modelData.dismiss()
					}
				}
			}
		}
	}
}
