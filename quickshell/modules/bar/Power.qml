import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: powerWid
    color: "transparent"
    height: 18
    width: 20

    Text {
        anchors.centerIn: parent
        text: "⏻"
        color: Theme.textColour
        font.pointSize: 12
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Quickshell.execDetached(["/usr/bin/env", "bash", "-lc", "$HOME/.config/rofi-popouts/power-menu"]);
        }
        hoverEnabled: true
        onEntered: parent.color = Theme.accentColour
        onExited: parent.color = "transparent"
    }
}
