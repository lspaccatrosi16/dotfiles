import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    property string textColour: "#cecece"
    property string accentColour: "#095217"
    property string backgroundColour: "#1b1b1b"
    property string middleColour: "#404040"

    anchors {
        top: true
        left: true
        right: true
    }
    color: "#00000000"
    height: 30
    exclusiveZone: root.height   // keep windows from overlapping the bar

    Rectangle {
        color: root.backgroundColour
        implicitWidth: Screen.width / 2
        height: 30
        radius: 15
        anchors.centerIn: parent
        border.width: 2
        border.color: root.accentColour

        RowLayout {
            id: bar
            anchors.fill: parent
            anchors.margins: 6
            spacing: 10

            // ===== LEFT: Hyprland workspaces =====
            Rectangle {
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                radius: 9
                height: 18
                width: 26
                color: root.accentColour

                Text {
                    anchors.centerIn: parent
                    color: root.textColour
                    text: Hyprland.focusedWorkspace.name
                }
            }

            // push clock to centre
            Item {
                Layout.fillWidth: true
            }

            // ===== CENTER: Clock (your original logic) =====
            Text {
                id: clock
                color: root.textColour
                font.family: "Fira Code"
                font.pointSize: 10
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

                Process {
                    id: dateProc
                    command: ["date", "+%a %d %b  %H:%M"]
                    running: true
                    stdout: StdioCollector {
                        onStreamFinished: clock.text = this.text
                    }
                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: dateProc.running = true
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Rectangle {
                id: batWid
                color: root.middleColour
                Layout.alignment: Qt.AlignTop
                height: 18
                radius: 9
                width: 90

                Text {
                    id: batLab
                    anchors.centerIn: parent
                    color: root.textColour
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

            Rectangle {
                id: volWid
                color: root.middleColour
                Layout.alignment: Qt.AlignTop
                height: 18
                radius: 9
                width: 90

                PwObjectTracker {
                    id: linkTracker
                    objects: [Pipewire.defaultAudioSink]
                }

                Text {
                    id: audioLabel
                    anchors.centerIn: parent
                    color: root.textColour
                    font.family: "Fira Code"
                    font.pointSize: 10
                    text: {
                        if (!Pipewire.defaultAudioSink)
                            return "–";
                        if (!Pipewire.defaultAudioSink.audio)
                            return "-";
                        if (Pipewire.defaultAudioSink.audio.muted)
                            return "vol: 0%";
                        return "vol: " + Math.round(Pipewire.defaultAudioSink.audio.volume * 100) + "%";
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Quickshell.execDetached(["/usr/bin/env", "bash", "-lc", "$HOME/.config/rofi-popouts/audio-menu"]);
                    }
                    hoverEnabled: true
                    onEntered: parent.color = root.accentColour
                    onExited: parent.color = root.middleColour
                }
            }

            Rectangle {
                id: netWid
                color: root.middleColour
                Layout.alignment: Qt.AlignTop
                height: 18
                radius: 9
                width: 30

                property string currentSsid: ""

                Image {
                    id: netIcon
                    source: {
                        return Qt.resolvedUrl("./icons/wifi.svg");
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
                    onEntered: parent.color = root.accentColour
                    onExited: parent.color = root.middleColour
                }
            }

            Rectangle {
                id: powerWid
                color: root.middleColour
                Layout.alignment: Qt.AlignTop
                height: 18
                radius: 9
                width: 30

                Text {
                    anchors.centerIn: parent
                    text: "⏻"
                    color: root.textColour
                    font.pointSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Quickshell.execDetached(["/usr/bin/env", "bash", "-lc", "$HOME/.config/rofi-popouts/power-menu"]);
                    }
                    hoverEnabled: true
                    onEntered: parent.color = root.accentColour
                    onExited: parent.color = root.middleColour
                }
            }

            // ===== Optional: System tray =====
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
    }
}
