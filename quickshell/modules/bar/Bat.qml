import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: batWid
    color: "transparent"
    height: 18
    width: 80

    Text {
        id: batLab
        anchors.centerIn: parent
        color: Theme.textColour
        font.family: "Fira Code"
        font.pointSize: 10
        }

        Process {
            id: batProc
            command: ["acpi", "2&>1", "|", "awk", "'print{$4}'"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: {
                    const found = /[0-9][0-9]+%/.exec(this.text);
    
                    // batLab.text = "bat: " + spl[3].split("%")[0] + "%"
                    batLab.text = "bat: " + found[0]
                }
            }
        }
    Timer {
        interval: 1000 * 15
        running: true
        repeat: true
        onTriggered: batProc.running = true
    }
}
