import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Scope {
    property bool isVisible: true

    PanelWindow {
        id: root

        anchors {
            top: true
            left: true
            right: true
        }
        color: "#00000000"
        height: 30
        exclusiveZone: root.height   // keep windows from overlapping the bar
        visible: isVisible

        Rectangle {
            color: Theme.backgroundColour
            width: Screen.width / 2
            height: 30
            radius: 15
            anchors.centerIn: parent
            // border.width: 2
            // border.color: Theme.accentColour

            RowLayout {
                id: bar
                anchors.fill: parent
                anchors.margins: 6
                spacing: 10

                Workspaces {}
                Clock {}

                Item {
                    Layout.fillWidth: true
                }

                ControlCentre {}

            }
        }
    }

    function hide() {
        isVisible = false;
    }

    function show() {
        isVisible = true;
    }
}
