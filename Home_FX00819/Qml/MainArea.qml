import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml.Models 2.13
import "Common"

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

//    FocusScope {
//        anchors.fill: parent

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
                    rightMargin: 22
                    verticalCenter: parent.verticalCenter
                }

                WidgetHighlight {
                    id: mapFocus
                    anchors.fill: parent
                    onClicked: openApplication("qrc:/Apps/Map/Map.qml")
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
                    id: climateFocus
                    anchors.fill: parent
                    disable: true
                }

                // Key navigation
                Keys.onLeftPressed: mapWidget
                Keys.onRightPressed: musicFocus
            }

            // Music player Widget
            MusicWidget {
                id: musicWidget
                width: 615
                height: parent.height
                anchors {
                    left: climateWidget.right
                    leftMargin: 22
                    verticalCenter: parent.verticalCenter
                }

                WidgetHighlight {
                    id: musicFocus
                    anchors.fill: parent
                    onClicked:
                        openApplication("qrc:/Apps/MusicPlayer/qml/MusicPlayer.qml")
                }

                // Key navigation
                Keys.onLeftPressed: climateWidget
            }
        }
        //--------------------------------------------------------------------//
        // End widgetsArea
        //--------------------------------------------------------------------//

        //--------------------------------------------------------------------//
        // Begin Menu area
        //--------------------------------------------------------------------//
        Item {
            id: menuArea

            anchors {
                top: widgetsArea.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            //----------------------------------------------------------------//
            // Begin Component Delegate
            //----------------------------------------------------------------//
            Component {
                id: appsDelegate

                DropArea {
                    id: dropArea

                    property int visualIndex: DelegateModel.itemsIndex

                    width: (appsMenu.width - (appsMenu.spacing * 5)) / 6 // 295
                    height: appsMenu.height
                    keys: "AppButton"
                    anchors.verticalCenter: parent.verticalCenter

                    onEntered: visualModel.items.move(drag.source.visualIndex,
                                                      appItem.visualIndex)

                    Binding {
                        target: appItem
                        property: "visualIndex"
                        value: visualIndex
                    }

                    Item {
                        id: appItem

                        property int visualIndex: 0

                        property var iconSrc:
                            appsModel.data(appsModel.index(visualIndex, 0), 259)

                        property var appName:
                            appsModel.data(appsModel.index(visualIndex, 0), 257)

                        property var appUrl:
                            appsModel.data(appsModel.index(visualIndex, 0), 258)

                        anchors.fill: dropArea

                        Drag.active: appButton.held
                        Drag.source: dropArea
                        Drag.keys: "AppButton"
                        Drag.hotSpot.x: appButton.width / 2

                        Button {
                            id: appButton

                            property bool held: false

                            icon_src: appItem.iconSrc
                            button_title: appItem.appName
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter

                            drag.target: held ? appItem : undefined
                            drag.axis: Drag.XAxis

                            onClicked: openApplication(appItem.appUrl)

                            onPressAndHold: {
                                held = true
                                focus = false
                            }

                            onReleased: held = false
                        }

                        states: State {
                            when: appButton.held

                            ParentChange {
                                target: appItem
                                parent: menuArea
                            }

                            AnchorChanges {
                                target: appItem
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    }
                }
            }
            //----------------------------------------------------------------//
            // End Component Delegate
            //----------------------------------------------------------------//

            // Delegate Model for apps menu
            DelegateModel {
                id: visualModel
                model: appsModel
                delegate: appsDelegate
            }

            //----------------------------------------------------------------//
            // Begin Listview for apps menu
            //----------------------------------------------------------------//
            ListView {
                id: appsMenu

                spacing: 22
                model: visualModel
                orientation: ListView.Horizontal
                snapMode: ListView.SnapToItem

                anchors {
                    fill: parent
                    topMargin: 10
                    bottomMargin: 20
                    leftMargin: 20
                    rightMargin: 20
                }

                displaced: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        easing.type: Easing.OutQuad
                    }
                }

                // Scrollbar
                ScrollBar.horizontal: scrollBar
            }
            //----------------------------------------------------------------//
            // End Listview for apps menu
            //----------------------------------------------------------------//

            // Scroll bar
            ScrollBar {
                id: scrollBar
                parent: appsMenu.parent
                height: 10
                orientation: Qt.Horizontal
                policy: ScrollBar.AlwaysOn
                snapMode: ScrollBar.SnapOnRelease

                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                background: Rectangle {
                    id: bgScrollBar
                    color: "#808080"
                }

                contentItem: Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    color: "#7deef8"
                }
            }
        }
        //--------------------------------------------------------------------//
        // End Menu area
        //--------------------------------------------------------------------//

//    }
}
