import QtQuick.Window
import QtQuick.Controls

TitleBarForm {
    id: root

    property double _lastX
    property double _lastY

    // Calcule dinamyc by screen, maybe use FrameAnimation
    property int _msByHz: 16 // 60 hz

    function _handleMaximizeButton() {
        ApplicationWindow.window.visibility
                = root.vIsFullscreen ? Window.Windowed : Window.FullScreen
    }

    function _handleMinimizeButton() {
        ApplicationWindow.window.showMinimized()
    }

    function _handleCloseButton() {
        ApplicationWindow.window.close()
    }

    function _handleMoveWindowPressed(mouse) {
        moveWindowArea._position = Qt.point(mouse.x, mouse.y)
        moveWindowArea._previousX = moveWindowArea.mouseX
    }

    Timer {
        id: throttleTimer
        interval: root._msByHz
        repeat: false
        onTriggered: root._handleMoveWindowPositionChanged()
    }

    /*!
        \qmlmethod void TitleBar::_handleMoveWindowPositionChanged()

        Possibility to move the screen in all directions of the monitor by controlling x and y
    */
    function _handleMoveWindowPositionChanged() {
        var diff = Qt.point(root._lastX - moveWindowArea._position.x,
                            root._lastY - moveWindowArea._position.y)

        ApplicationWindow.window.x += diff.x
        ApplicationWindow.window.y += diff.y
    }

    /*!
        \qmlmethod void TitleBar::_handleThrottle()

        Start timer that execute _handleMoveWindowPositionChanged for refresh positions
    */
    function _handleThrottle(mouse) {
        root._lastX = mouse.x
        root._lastY = mouse.y
        if (!throttleTimer.running) {
            throttleTimer.start()
        }
    }

    moveWindowArea.onPositionChanged: mouse => _handleThrottle(mouse)
    moveWindowArea.onPressed: mouse => root._handleMoveWindowPressed(mouse)
    maximizeButton.onClicked: root._handleMaximizeButton()
    minimizeButton.onClicked: root._handleMinimizeButton()
    closeButton.onClicked: root._handleCloseButton()
}
