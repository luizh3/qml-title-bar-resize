pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Control {
    id: root
    width: parent.width
    height: 50

    property int vRadius: 8

    required property bool vIsFullscreen

    property string vBackgroundColor: "#5d5d5d"

    property alias closeButton: closeButton
    property alias minimizeButton: minimizeButton
    property alias maximizeButton: maximizeButton
    property alias moveWindowArea: moveWindowArea

    component HeaderButton: Button {
        id: headerButton
        width: 50
        height: parent.height
        display: AbstractButton.IconOnly

        property int vTopRightRadius: 0
        property string vHoverColor: "#777777"
        property string vIcontHoverColor: "#2f2f2f"
        property string vIconColor: "#FFFFFF"

        icon.source: "minus"
        icon.color: headerButton.vIconColor
        icon.width: 22
        icon.height: 22

        background: Rectangle {
            color: headerButton.hovered ? headerButton.vHoverColor : root.vBackgroundColor

            topRightRadius: headerButton.vTopRightRadius

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }
        }
    }

    contentItem: Rectangle {
        color: root.vBackgroundColor
        topRightRadius: root.vIsFullscreen ? 0 : root.vRadius
        topLeftRadius: root.vIsFullscreen ? 0 : root.vRadius

        Text {
            text: ApplicationWindow.window.title
            color: "#FFFFFF"
            font.pixelSize: 16
            font.bold: true

            anchors {
                left: parent.left
                leftMargin: 16
                verticalCenter: parent.verticalCenter
            }
        }

        MouseArea {
            id: moveWindowArea

            anchors {
                left: parent.left
                right: row.right
                bottom: parent.bottom
                top: parent.top
            }

            property real _previousX
            property point _position
        }

        Row {
            id: row
            height: parent.height
            anchors.right: parent.right
            layoutDirection: Qt.RightToLeft

            HeaderButton {
                id: closeButton
                icon.source: "qrc:/icons/x"
                vHoverColor: "#ea615d"
                vTopRightRadius: root.vIsFullscreen ? 0 : root.vRadius
            }
            HeaderButton {
                id: maximizeButton
                icon.source: "qrc:/icons/square"
            }

            HeaderButton {
                id: minimizeButton
                icon.source: "qrc:/icons/minus"
            }
        }
    }
}
