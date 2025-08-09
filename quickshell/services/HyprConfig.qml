pragma Singleton

import QtQuick
import Quickshell
import "../theme/colours.js" as Colours

QtObject {
    id: root

    property var default_config: ({
            "general:border_size": 2,
            "general:gaps_in": 5,
            "general:gaps_out": 10,
            "general:col.active_border": "rgb(" + Colours.accentColour.substring(1)+ ")",
            "general:col.inactive_border": "rgb(" + Colours.middleColour.substring(1)+ ")",
            "decoration:rounding": 5,
            "decoration:roundingPower": 1,
            "decoration:active_opacity": 0.9,
            "decoration:inactive_opacity": 0.9
        })

    property var config: ({})

    function kw(name, value) {
        Quickshell.execDetached(["hyprctl", "keyword", name, value]);
    }

    function updateProperty(name, value) {
        config[name] = value;
        kw(name, value);
    }

    function setDefaultProperty(name) {
        config[name] = default_config[name];
        kw(name, config[name]);
    }

    function getProperty(name) {
        return config[name];
    }

    function init() {
        Object.assign(config, default_config);
        for (const [key, value] of Object.entries(config)) {
            kw(key, value);
        }
    }
}
