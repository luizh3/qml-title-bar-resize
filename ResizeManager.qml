import QtQuick
import QtQuick.Controls

/*!
    \qmltype ResizeManager
    \brief A Manager to control resize window

    Control the resizing that can be make by the window edges

    The resizing of the left and top are still a bit buggy, because they go against the natural direction of y and x. ( working in this )
*/

Item {
    id: root

    /*!
        \qmlmethod void ResizeManager::easeOut()

        One way to make transition more smoth, uses a concept similar to ease out

    */
    function easeOut(size, sumSize, smoth) {
        return size * (1 - smoth) + (size + sumSize) * smoth
    }

    /*!
        \qmlmethod void ResizeManager::learp()

        One way to make transition more smoth, uses a concept similar to learp.

    */
    function learp(size, sumSize, smoth) {
        return size + ((sumSize) * smoth)
    }

    property real _previousX
    property real _previousWidth
    property real _windowPreviusX

    property real _previousY
    property real _previousHeight
    property real _windowPreviusY

    property real _smothTransition: 0.5
    property int _borderSize: 5

    MouseArea {
        id: leftBorderArea

        width: root._borderSize

        cursorShape: Qt.SizeHorCursor

        anchors {
            bottom: parent.bottom
            top: parent.top
            left: parent.left
        }

        onPressed: function () {
            root._previousWidth = ApplicationWindow.window.width
            root._previousX = leftBorderArea.mouseX
            root._windowPreviusX = ApplicationWindow.window.x
        }

        onPositionChanged: function (mouse) {

            const sumSize = (mouse.x - root._previousX) * -1

            var newWidth = root.learp(ApplicationWindow.window.width, sumSize,
                                      root._smothTransition)

            newWidth = Math.max(ApplicationWindow.window.minimumWidth,
                                Math.min(newWidth,
                                         ApplicationWindow.window.maximumWidth))

            const widthDiff = newWidth - root._previousWidth

            ApplicationWindow.window.x = root._windowPreviusX - widthDiff
            ApplicationWindow.window.width = newWidth
        }
    }

    MouseArea {
        id: bottomBorderArea

        height: root._borderSize

        anchors {
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }

        cursorShape: Qt.SizeHorCursor

        onPressed: function () {
            root._previousY = bottomBorderArea.mouseY
        }

        onPositionChanged: function (mouse) {

            const newHeight = root.learp(ApplicationWindow.window.height,
                                         (mouse.y - root._previousY),
                                         root._smothTransition)

            ApplicationWindow.window.height = Math.max(
                        ApplicationWindow.window.minimumHeight,
                        Math.min(newHeight,
                                 ApplicationWindow.window.maximumHeight))
        }
    }

    MouseArea {
        id: topBorderArea

        height: root._borderSize

        cursorShape: Qt.SizeHorCursor

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        parent: Overlay.overlay

        onPressed: function () {
            root._previousHeight = root.height
            root._previousY = topBorderArea.mouseY
            root._windowPreviusY = ApplicationWindow.window.y
        }

        onPositionChanged: function (mouse) {

            const sumSize = (mouse.y - root._previousY) * -1

            var newHeight = root.learp(ApplicationWindow.window.height,
                                       sumSize, root._smothTransition)

            newHeight = Math.max(
                        ApplicationWindow.window.minimumHeight,
                        Math.min(newHeight,
                                 ApplicationWindow.window.maximumHeight))

            ApplicationWindow.window.height = newHeight

            const diffHeight = newHeight - root._previousHeight

            ApplicationWindow.window.y = root._windowPreviusY - diffHeight
        }
    }

    MouseArea {
        id: rightBorderArea

        width: root._borderSize

        anchors {
            right: parent.right
            bottom: parent.bottom
            top: parent.top
        }

        cursorShape: Qt.SizeHorCursor

        onPressed: function () {
            root._previousX = rightBorderArea.mouseX
        }

        onPositionChanged: function (mouse) {

            const newWidth = root.learp(ApplicationWindow.window.width,
                                        (mouse.x - root._previousX),
                                        root._smothTransition)

            ApplicationWindow.window.width = Math.max(
                        ApplicationWindow.window.minimumWidth,
                        Math.min(newWidth,
                                 ApplicationWindow.window.maximumWidth))
        }
    }
}
