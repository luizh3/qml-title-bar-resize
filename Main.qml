import QtQuick
import QtQuick.Window
import QtQuick.Controls

ApplicationWindow {
    id: application
    width: 640
    height: 480
    visible: true
    title: qsTr("QML Title Bar")
    color: "transparent"

    flags: Qt.Window | Qt.FramelessWindowHint

    minimumWidth: 400
    minimumHeight: 400

    maximumWidth: Screen.width
    maximumHeight: Screen.height

    property bool vIsFullscreen: application.visibility === Window.FullScreen

    ResizeManager {
        anchors.fill: parent
    }

    background: Rectangle {
        color: "#2f2f2f"
        radius: application.vIsFullscreen ? 0 : 8
    }

    header: TitleBar {
        vIsFullscreen: application.vIsFullscreen
    }
}
