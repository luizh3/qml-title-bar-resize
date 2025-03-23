import QtQuick.Window
import QtQuick.Controls

TitleBarForm {
    id: root

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

    /*!
        \qmlmethod void TitleBar::_handleMoveWindowPositionChanged()

        Possibility to move the screen in all directions of the monitor by controlling x and y
    */

    function _handleMoveWindowPositionChanged(mouse){
        var diff = Qt.point(mouse.x - moveWindowArea._position.x,
                            mouse.y - moveWindowArea._position.y)
        ApplicationWindow.window.x += diff.x
        ApplicationWindow.window.y += diff.y
    }

    moveWindowArea.onPositionChanged: (mouse) => root._handleMoveWindowPositionChanged(mouse)
    moveWindowArea.onPressed: (mouse) => root._handleMoveWindowPressed(mouse)
    maximizeButton.onClicked: root._handleMaximizeButton()
    minimizeButton.onClicked: root._handleMinimizeButton()
    closeButton.onClicked: root._handleCloseButton()
}
