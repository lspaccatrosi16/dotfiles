import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: clock
    color: Theme.middleColour
    Layout.alignment: Qt.AlignTop
    height: 18
    radius: 9
    width: 150

    Text {
        id: clockText
        anchors.centerIn: parent
        color: Theme.textColour
        font.family: "Fira Code"
        font.pointSize: 10
    }

    Process {
        id: dateProc
        command: ["date", "+%a %d %b  %H:%M"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: clockText.text = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
