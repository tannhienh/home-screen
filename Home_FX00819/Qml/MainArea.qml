import QtQuick 2.13
import QtQuick.Controls 2.13

// Main Area
// Width: 1920
// height: 995
Item {
    id: rootMainArea

    // Open application function
    // Push application screen into stackview
    function openApplication(url)
    {
        parent.push(url)
    }

    FocusScope {
        anchors.fill: parent

        //--------------------------------------------------------------------//
        // Begin widgetsArea
        //--------------------------------------------------------------------//
        // Widgets Area: Map widget, Climate widget, Music Player widget
        // Width: 1920
        // Height: 550
        Item {
            id: widgetsArea
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 550

            // Map Navigation Widget
            MapWidget {
                id: mapWidget
                width: 615
                height: parent.height
                anchors {
                    right: climateWidget.left
                    rightMargin: 20
                    verticalCenter: parent.verticalCenter
                }

                WidgetHighlight {
                    id: mapHighlight
                    anchors.fill: parent
                    onClicked: {
                        if (statusBar.editting === false) {
                            statusBar.isShowEditButton = false
                            openApplication("qrc:/Apps/Map/qml/Map.qml")
                        }
                    }
                }

                // Key navigation
                Keys.onRightPressed: climateWidget
            }

            // Climate Widget
            // Width: 615
            // Height: 550
            ClimateWidget {
                id: climateWidget
                width: 615
                height: parent.height
                anchors.centerIn: parent

                WidgetHighlight {
                    id: climateHighlight
                    anchors.fill: parent
                    disable: true
                }

                // Key navigation
                Keys.onLeftPressed: mapWidget
                Keys.onRightPressed: musicHighlight
            }

            // Music player Widget
            MusicWidget {
                id: musicWidget
                width: 615
                height: parent.height
                anchors {
                    left: climateWidget.right
                    leftMargin: 20
                    verticalCenter: parent.verticalCenter
                }

                // Key navigation
                Keys.onLeftPressed: climateWidget
            }
        }
        //--------------------------------------------------------------------//
        // End widgetsArea
        //--------------------------------------------------------------------//

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
