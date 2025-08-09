import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import "../../theme/colours.js" as Theme

Scope {
    Repeater {
        model: SystemTray.items
        delegate: Rectangle {
            width: 22
            height: 22
            color: "transparent"
            Image {
                anchors.centerIn: parent
                source: modelData.icon
                sourceSize.width: 18
                sourceSize.height: 18
                fillMode: Image.PreserveAspectFit
            }
            MouseArea {
                anchors.fill: parent
                onClicked: modelData.hasMenu ? modelData.display(parent, 0, parent.height) : modelData.activate()
                onWheel: modelData.scroll(wheel.angleDelta.y, false)
                hoverEnabled: true
                onEntered: parent.color = "#262626"
                onExited: parent.color = "transparent"
            }
        }
    }
}
