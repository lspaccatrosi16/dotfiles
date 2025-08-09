import QtQuick
import QtQuick.Layouts
import "../../theme/colours.js" as Theme

Rectangle {
    id: root
    color: Theme.middleColour
    Layout.alignment: Qt.AlignTop
    implicitHeight: 18
    radius: 9
    implicitWidth: 230

    RowLayout {
        id: bar
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        
        Bat {}
        Audio {}
        Net {}
        Power {}
    }
}
