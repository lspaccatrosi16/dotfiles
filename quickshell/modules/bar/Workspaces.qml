import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    Layout.alignment: Qt.AlignTop | Qt.AlignLeft
    radius: 9
    height: 18
    width: 26
    color: Theme.accentColour

    Text {
        anchors.centerIn: parent
        color: Theme.textColour
        text: Hyprland.focusedWorkspace.name
    }
}
