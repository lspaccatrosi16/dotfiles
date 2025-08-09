import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: batWid
    color: Theme.middleColour
    Layout.alignment: Qt.AlignTop
    height: 18
    radius: 9
    width: 90

    Text {
        id: batLab
        anchors.centerIn: parent
        color: Theme.textColour
        font.family: "Fira Code"
        font.pointSize: 10

        Process {
            id: batProc
            command: ["acpi", "2&>1", "|", "awk", "'print{$4}'"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: {
                    const initial = this.text;
                    const spl = initial.split(" ");
                    batLab.text = "bat: " + spl[3];
                }
            }
        }
    }
}
