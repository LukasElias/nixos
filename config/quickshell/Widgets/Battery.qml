import Quickshell.Services.UPower

import QtQuick
import QtQuick.Layouts

import "../config.js" as Config

RowLayout {
    id: root

    property UPowerDevice displayDevice: UPower.displayDevice

    readonly property bool ready: displayDevice && displayDevice.ready
    readonly property int percentage: ready ? Math.round(displayDevice.percentage * 100) : 0
    readonly property bool charging: ready && (displayDevice.state == UPowerDeviceState.Charging || displayDevice.state == UPowerDeviceState.FullyCharged)

    readonly property string textColor: {
        if (!ready)
            return "000";
        if (percentage <= 20)
            return Config.palette.base08;
        if (percentage <= 30)
            return Config.palette.base0A;

        return Config.palette.base0B;
    }
    readonly property string icon: {
        if (!ready)
            return "";
        // Charging icons (THESE ARE NOT IN ORDER IN NERDFONTS FOR SOME REASON)
        if (charging) {
            let chargingIcons = [0xf089c // 10%
                , 0xf0086 // 20%
                , 0xf0087 // 30%
                , 0xf0088 // 40%
                , 0xf089d // 50%
                , 0xf0089 // 60%
                , 0xf089e // 70%
                , 0xf008a // 80%
                , 0xf008b // 90%
                , 0xf0085, // 100%
            ];

            return String.fromCodePoint(chargingIcons[Math.max(0, Math.ceil(percentage / 10) - 1)]);
        }

        // Normal Icons
        if (percentage > 90)
            return String.fromCodePoint(0xf0079);

        return String.fromCodePoint(0xf007a + Math.max(0, Math.ceil(percentage / 10) - 1));
    }
    readonly property string text: {
        if (!ready)
            return "-";

        return `${icon} ${percentage}%`;
    }

    Text {
        text: root.text
        color: `#${root.textColor}`
        font: Config.font
    }
}
