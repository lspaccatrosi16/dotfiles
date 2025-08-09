import "modules/display"
import qs.services
import Quickshell
import QtQuick

ShellRoot {
    Display {}

    Component.onCompleted: {
        HyprConfig.init()
    }
}
