import Quickshell
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Scope {
	id: root

	NotificationServer {
		id: server

		bodySupported: true
		imageSupported: true
		actionsSupported: true

		onNotification: (notification) => {
			console.log("recieved notification: ", notification.summary, "---", notification.body)

			notification.tracked = true
		}
	}

	PanelWindow {
		id: window

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
		implicitHeight: Math.max(1, column.implicitHeight)

		ColumnLayout {
			id: column
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
								id: summary

								text: card.modelData.summary
								color: `#${Config.palette.base0B}`
								font: {
									family: Config.font.family
									pixelSize: Config.font.pixelSize
									bold: true
								}

								visible: text !== ""
							}

							Text {
								id: body

								text: card.modelData.body
								color: `#${Config.palette.base05}`
								font: Config.font

								wrapMode: Text.WorkWrap
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
