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
            focus: true

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

                // Key navigation for Map widget
                KeyNavigation.right: climateWidget
                KeyNavigation.down: menuArea

                /**
                  * When Enter key released:
                  * - Change state Map widget to "Focus"
                  * - and open Map application
                  */
                Keys.onReleased: {
                    if (event.key === Qt.Key_Enter) {
                        stateHighLight = "Focus"
                        event.accepted = true
                        Common.openApp("qrc:/Apps/Map/qml/Map.qml")
                    }
                }
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

                // Key navigation for Climate widget
                KeyNavigation.left: mapWidget
                KeyNavigation.right: musicWidget
                KeyNavigation.down: menuArea
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

                // Key navigation or Music widget
                KeyNavigation.left: climateWidget
                KeyNavigation.down: menuArea
                Keys.onEnterPressed: {
                }

                /**
                  * When Enter key released:
                  * - Change state Music widget to "Focus"
                  * - and open Music application
                  */
                Keys.onReleased: {
                    if (event.key === Qt.Key_Enter) {
                        stateHighLight = "Focus"
                        event.accepted = true
                        Common.openApp("qrc:/Apps/MusicPlayer/qml/MusicPlayer.qml")
                    }
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
