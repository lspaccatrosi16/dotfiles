import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: volWid
    color: Theme.middleColour
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
        color: Theme.textColour
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
        onEntered: parent.color = Theme.accentColour
        onExited: parent.color = Theme.middleColour
    }
}
