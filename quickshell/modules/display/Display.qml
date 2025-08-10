import Quickshell
import Quickshell.Hyprland
import qs.modules.bar
import qs.services

Scope {
    id: root
    property bool isFullscreen: false

    Bar {
        id: bar
    }

    GlobalShortcut {
        id: fullScrSc
        name: "fullscreen"
        description: "Toggles fullscreen"

        onPressed: {
            if (!root.isFullscreen) {
                root.isFullscreen = true;

                bar.hide();

                HyprConfig.updateProperty("general:border_size", 0);
                HyprConfig.updateProperty("general:gaps_out", 0);
                HyprConfig.updateProperty("general:gaps_in", 0);
                HyprConfig.updateProperty("decoration:rounding", 0);
            } else {
                root.isFullscreen = false;

                bar.show();

                HyprConfig.setDefaultProperty("general:border_size");
                HyprConfig.setDefaultProperty("general:gaps_out");
                HyprConfig.setDefaultProperty("general:gaps_in");
                HyprConfig.setDefaultProperty("decoration:rounding");
            }
        }
    }
}
