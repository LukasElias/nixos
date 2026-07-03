import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
	id: root

	property int lastCpuTotal: 0
	property int lastCpuIdle: 0
	property int cpuUsage: 0

	property int memUsage: 0

	Process {
		id: cpuProc

		running: true
		command: [ "head", "-1", "/proc/stat" ]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return

				let p = data.trim().split(/\s+/)
				let idle = parseInt(p[4]) + parseInt(p[5])
				let total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)

				if (root.lastCpuTotal > 0) {
					root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)))
				}

				root.lastCpuTotal = total
				root.lastCpuIdle = idle
			}
		}
	}

	Process {
		id: memProc
		command: ["bash", "-c", "free | grep Mem"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				var parts = data.trim().split(/\s+/)
				var total = parseInt(parts[1]) || 1
				var used = parseInt(parts[2]) || 0
				root.memUsage = Math.round(100 * used / total)
			}
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 10000
		running: true
		repeat: true
		onTriggered: {
			cpuProc.running = true
			memProc.running = true
		}
	}

	Text {
		id: cpuUsageText

		text: "CPU: " + root.cpuUsage + "%"
		color: `#${Config.palette.base05}`
		font: Config.font
	}

	Text {
		id: memUsageText

		text: "MEM: " + root.memUsage + "%"
		color: `#${Config.palette.base05}`
		font: Config.font
	}
}
