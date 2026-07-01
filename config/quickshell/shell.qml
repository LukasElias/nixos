import Quickshell

import QtQuick
import QtQuick.Layouts

ShellRoot {
	id: root

	Variants {
		model: Quickshell.screens

		delegate: Bar {}
	}
}
