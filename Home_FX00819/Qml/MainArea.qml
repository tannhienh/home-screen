import QtQuick 2.13
import QtQuick.Controls 2.13

// Javascript common function
import "../Js/Common.js" as Common

FocusScope {
    id: focusScopeMainArea

    /**
     * Open application function
     * Push application screen into stackview
     */
    function openApplication(appPath)
    {
        parent.push(appPath)
    }

    /**
     * Main Area
     * Width: 1920
     * height: 995
     */
    Rectangle {
        id: rootMainArea
        anchors.fill: parent
        color: "transparent"

        /**
         * Begin widgetsArea
         *
         * Widgets Area: Map widget, Climate widget, Music Player widget
         * Width: 1920
         * Height: 550
         */
        FocusScope {
            id: widgetsArea
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 550
            focus: menuArea.focus ? false : true

            /**
             * Map Navigation Widget
             * Width: 615
             * Height: 550
             */
            MapWidget {
                id: mapWidget
                width: 615
                height: parent.height
                anchors {
                    right: climateWidget.left
                    rightMargin: 20
                    verticalCenter: parent.verticalCenter
                }

                // Focus navigation to status bar if Edit button and Done button
                // visible
                KeyNavigation.up: {
                    if (statusBar.isShowEditButton || statusBar.editting)
                        return statusBar
                    else
                        return mapWidget
                }

                // Key navigation for Map widget
                KeyNavigation.right: climateWidget
                KeyNavigation.down: menuArea

                /**
                  * When Enter key released:
                  * - Change state Map widget to "Focus"
                  * - and open Map application
                  */
                Keys.onReleased: {
                    if (event.key === Qt.Key_Return) {
                        stateHighLight = "Focus"
                        event.accepted = true
                        Common.openApp("qrc:/Apps/Map/qml/Map.qml")
                    }
                }

                onFocusChanged: if (focus)
                        parent.focus = true
            }

            /**
             * Climate Widget
             * Width: 615
             * Height: 550
             */
            ClimateWidget {
                id: climateWidget
                width: 615
                height: parent.height
                anchors.centerIn: parent
                focus: true

                // Focus navigation to status bar if Edit button and Done button
                // visible
                KeyNavigation.up: {
                    if (statusBar.isShowEditButton || statusBar.editting)
                        return statusBar
                    else
                        return climateWidget
                }

                KeyNavigation.left: mapWidget
                KeyNavigation.right: musicWidget
                KeyNavigation.down: menuArea

                onFocusChanged:  if (focus)
                                     parent.focus = true
            }

            /**
             * Music player Widget
             * Width: 615
             * Height: 550
             */
            MusicWidget {
                id: musicWidget
                width: 615
                height: parent.height
                anchors {
                    left: climateWidget.right
                    leftMargin: 20
                    verticalCenter: parent.verticalCenter
                }

                // Focus navigation to status bar if Edit button and Done button
                // visible
                KeyNavigation.up: {
                    if (statusBar.isShowEditButton || statusBar.editting)
                        return statusBar
                    else
                        return musicWidget
                }

                // Key navigation or Music widget
                KeyNavigation.left: climateWidget
                KeyNavigation.down: menuArea

                /**
                  * When Enter key released:
                  * - Change state Music widget to "Focus"
                  * - and open Music application
                  */
                Keys.onReleased: {
                    if (event.key === Qt.Key_Return) {
                        stateHighLight = "Focus"
                        event.accepted = true
                        Common.openApp("qrc:/Apps/MusicPlayer/qml/MusicPlayer.qml")
                    }
                }

                onFocusChanged: if (focus)
                                    parent.focus = true
            }

            /**
              * - If change focus from status bar or apps menu to widgets area
              * then Climate widget will be focus
              * - If change focus from widgets area to status bar or apps menu
              * then Map widget, Climate widget and Music widget focus change to
              * false
              */
            onFocusChanged: {
                if (focus) {
                    if (menuArea.focus)
                        menuArea.focus = false
                    if (!mapWidget.focus && !climateWidget.focus
                            && !musicWidget.focus)
                        climateWidget.focus = true

                } else {
                    mapWidget.focus = false
                    climateWidget.focus = false
                    musicWidget.focus = false
                }
            }

            Connections {
                target: mainAreaStackView
                onFocusChanged: {
                    if (!mainAreaStackView.focus && widgetsArea.focus)
                        widgetsArea.focus = false

                    if (mainAreaStackView.focus)
                        climateWidget.focus = true
                }
            }
        }
        // End widgetsArea

        // Apps Menu area
        AppsMenu {
            id: menuArea

            property bool moveRight: false

            anchors {
                top: widgetsArea.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
        }
    }
}
