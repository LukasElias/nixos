import Quickshell.Bluetooth

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
    Repeater {
        model: Bluetooth.adapters

        RowLayout {
            id: adapter
            required property BluetoothAdapter modelData

            // Devices
            Repeater {
                model: adapter.modelData.devices

                Text {
                    id: device
                    required property BluetoothDevice modelData

                    readonly property int battery: modelData.batteryAvailable ? Math.round(modelData.battery * 100) : null
                    readonly property string batteryIcon: {
                        if (!battery)
                            return;
                        if (battery > 90)
                            return String.fromCodePoint(0xf0948);

                        return String.fromCodePoint(0xf093e + Math.max(0, Math.ceil(battery / 10) - 1));
                    }
                    readonly property string displayText: {
                        if (!batteryIcon)
                            return modelData.name;

                        return `${batteryIcon} ${battery}% ${modelData.name}`;
                    }

                    visible: modelData.connected

                    text: displayText
                    color: `#${Config.palette.base05}`
                    font: Config.font
                }
            }
        }
    }
}
