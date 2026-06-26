import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

ShellRoot {
	id: root

	// Theme colors
	property color colBg: "#1a1b26"
	property color colFg: "#a9b1d6"
	property color colMuted: "#444b6a"
	property color colCyan: "#0db9d7"
	property color colPurple: "#ad8ee6"
	property color colRed: "#f7768e"
	property color colYellow: "#e0af68"
	property color colBlue: "#7aa2f7"
	
	// Font
	property string fontFamily: "Agave Nerd Font"
	property int fontSize: 18
	
	// System info properties
	property string kernelVersion: "Linux"
	property int cpuUsage: 0
	property int memUsage: 0
	property int diskUsage: 0
	property int volumeLevel: 0
	property string activeWindow: "Window"
	property string currentLayout: "Tile"
	
	// CPU tracking
	property var lastCpuIdle: 0
	property var lastCpuTotal: 0
	property SystemTray systemTray: SystemTray

	Variants {
		model: Quickshell.screens

		PanelWindow {
			property var modelData
			screen: modelData

			anchors {
				top: true
				left: true
				right: true
			}

			margins {
				top: 0
				bottom: 0
				left: 0
				right: 0
			}

			implicitHeight: 30

			Rectangle {
				anchors.fill: parent
				color: root.colBg

				RowLayout {
					anchors.fill: parent
					spacing: 0

					Rectangle {
						id: workspace
						Layout.preferredWidth: 30

						Text {
							text: Hyprland.focusedWorkspace.id
							color: "#fff"
							font.pixelSize: root.fontSize
							font.family: root.fontFamily

							anchors.centerIn: parent
						}
					}

					Item {
						Layout.preferredWidth: 10
					}

					Rectangle {
						id: tray
						color: "#0f0"

						RowLayout {
							Repeater {
								model: root.systemTray.items

								Rectangle {
									property SystemTrayItem modelData

									IconImage {
										anchors.fill: parent
										source: parent.modelData.icon
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
