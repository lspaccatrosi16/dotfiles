import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: netWid
    color: "transparent"
    height: 18
    width: 20

    property string currentSsid: ""

    Image {
        id: netIcon
        source: {
            return Qt.resolvedUrl("../../icons/wifi.svg");
        }
        sourceSize.width: 16
        sourceSize.height: 16
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            Quickshell.execDetached(["/usr/bin/env", "bash", "-lc", "$HOME/.config/rofi-popouts/net-menu"]);
        }
        hoverEnabled: true
        onEntered: parent.color = Theme.accentColour
        onExited: parent.color = "transparent"
    }
}
