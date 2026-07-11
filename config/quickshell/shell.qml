//@ pragma UseQApplication

import Quickshell

import QtQuick

ShellRoot {
	id: root

	Variants {
		model: Quickshell.screens

		delegate: Bar {}
	}

	Notifications {}

	LogoutMenu {}
}
