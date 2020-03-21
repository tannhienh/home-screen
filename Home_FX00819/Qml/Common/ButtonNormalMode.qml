import QtQuick 2.13

Button {
    id: appButton

    property int visualIndex: model.index

    property var appUrl: appsModel.data(appsModel.index(visualIndex, 0), 259)

    icon_src:  appsModel.data(appsModel.index(visualIndex, 0), 260)

    button_title: appsModel.data(appsModel.index(visualIndex, 0), 258)
    pressAndHoldInterval: statusBar.editting ? 500 : 1000

    focus: {
        if (!appsMenu.activeFocus) {
            return false
        }
        else if (appsMenu.currentIndex === model.index
                 && !statusBar.editting) {
            return true
        }
        else {
            return false
        }
    }

    // Change state to Pressed when the app button are press
    onPressed: {
        if (!statusBar.editting) {
            if (statusBar.isShowEditButton) {
                statusBar.isShowEditButton = false
            }

            appsMenu.currentIndex = model.index

            if (!appsMenuScope.focus) {
                appsMenuScope.focus = true
            }
            appButton.focus = true
            appButton.state = "Pressed"
        }
    }

    onPressAndHold: {
        if (statusBar.editting === false)
            statusBar.isShowEditButton = true
    }

    onReleased: appButton.state = "Focus"

    // Open app when app button was clicked
    onClicked: openApplication(appButton.appUrl)

    /**
     * When Enter key was pressed:
     * - Change state to "Pressed" if are Map or Music widget
     * - Nothing if is Climate widget
     */
    Keys.onReturnPressed: {
        state = "Pressed"
        event.accepted = true
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Return && !statusBar.editting) {
            statusBar.isShowEditButton = false
            state = "Focus"
            openApplication(appButton.appUrl)
            event.accepted = true
        }
    }

    // When focus changed
    // If which button not focusing, change state to Normal
    onFocusChanged: {
        if (menuArea.focus) {
            if (appButton.focus) {

                appButton.state = "Focus"
            }
            else {
                appButton.state = "Normal"
            }
        }
    }

    Connections {
        target: appsMenuScope
        onFocusChanged: {
            if (!appsMenuScope.focus
                    && appsMenu.currentIndex === model.index) {
                appButton.state = "Normal"
            }

            // HighLight app button when change focus from widget area
            // to menu by key
            if (appsMenuScope.focus
                    && appsMenu.currentIndex === model.index) {
                appButton.state = "Focus"
            }
        }
    }

    /**
      * Change focus app button when current index apps menu changed
      * true : if is current app
      * false: if not is current app
      */
    Connections {
        target: appsMenu
        onCurrentIndexChanged: {
            if (model.index === appsMenu.currentIndex)
                appButton.focus = true
            else
                appButton.focus = false
        }
    }
}
