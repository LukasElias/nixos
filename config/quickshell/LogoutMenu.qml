import Quickshell
import Quickshell.Io

import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Scope {
    id: root

    property bool menuOpen: false

    IpcHandler {
        target: "logoutmenu"

        function toggle() {
            root.menuOpen = !root.menuOpen;
        }

        function open() {
            root.menuOpen = true;
        }

        function close() {
            root.menuOpen = false;
        }
    }

    PanelWindow {
        id: logoutmenu

        visible: root.menuOpen

        color: "transparent"

        focusable: true

        anchors {
            top: true
            bottom: true
            right: true
            left: true
        }

        Shortcut {
            sequences: ["q", "Escape"]
            onActivated: root.menuOpen = false
        }

        Rectangle {
            anchors.fill: parent
            anchors.margins: 200

            color: `#aa${Config.palette.base00}`

            GridLayout {
                anchors.fill: parent
                columns: 3
                rows: 2
                columnSpacing: 10
                rowSpacing: 10

                Repeater {
                    model: Config.logoutmenu.buttons

                    Rectangle {
                        id: card
                        required property var modelData

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 8

                        color: `#${Config.palette.base01}`

                        Text {
                            text: `${card.modelData.text} [${card.modelData.keybind}]`

                            color: `#${Config.palette.base05}`

                            font: Config.font

                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: card.activate()
                        }

                        Shortcut {
                            sequence: card.modelData.keybind
                            autoRepeat: false
                            onActivated: card.activate()
                        }

                        function activate() {
                            command.startDetached();
                            root.menuOpen = false;
                        }

                        Process {
                            id: command
                            command: card.modelData.command
                        }
                    }
                }
            }
        }
    }
}
