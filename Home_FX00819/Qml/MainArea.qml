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
        // Start widgetsArea
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
        // Start Menu area
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
            // Start Component Delegate
            //----------------------------------------------------------------//
            Component {
                id: appsDelegate

                DropArea {
                    id: dropArea

                    property int visualIndex: DelegateModel.itemsIndex

                    width: appIcon.width
                    height: appIcon.height
                    keys: "AppButton"

                    Binding {
                        target: appIcon
                        property: "visualIndex"
                        value: visualIndex
                    }

                    Item {
                        id: appIcon

                        property int visualIndex: 0

                        property var iconSrc:
                            appsModel.data(appsModel.index(visualIndex, 0), 259)

                        property var appName:
                            appsModel.data(appsModel.index(visualIndex, 0), 257)

                        property var urlApp:
                            appsModel.data(appsModel.index(visualIndex, 0), 258)

                        width: appButton.width
                        height: appButton.height

                        Drag.active: appButton.drag.active
                        Drag.keys: "AppButton"
                        Drag.hotSpot.x: appButton.width / 2

                        Button {
                            id: appButton

                            property bool held: false

                            anchors.fill: parent

                            icon_src: appIcon.iconSrc
                            button_title: appIcon.appName

                            drag.target: held ? appIcon : undefined
                            drag.axis: Drag.XAxis

                            pressAndHoldInterval: 1000

                            onPressAndHold: {
                                statusBar.visibleEditButton = true
                                held = true
                            }

                            onReleased: held = false

                            onClicked: openApplication(appIcon.urlApp)
                        }

                        onFocusChanged: appButton.focus = appIcon.focus

                        states: State {
                            when: appButton.held

                            ParentChange {
                                target: appIcon
                                parent: menuArea
                            }

                            AnchorChanges {
                                target: appIcon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    }

                    onEntered: visualModel.items.move(drag.source.visualIndex,
                                                      appButton.visualIndex)

                }
            }
            //--------------------------------------------------------------------//
            // End Component Delegate
            //--------------------------------------------------------------------//

            //--------------------------------------------------------------------//
            // Start Listview for apps menu
            //--------------------------------------------------------------------//
            ListView {
                id: appsMenu

                orientation: ListView.Horizontal
                snapMode: ListView.SnapToItem
                spacing: 22

                anchors {
                    fill: parent
                    top: parent.top
                    topMargin: 10
                    bottom: parent.top
                    bottomMargin: 20
                    left: parent.left
                    leftMargin: 20
                    right: parent.right
                    rightMargin: 20
                }

                model: DelegateModel {
                    id: visualModel
                    model: appsModel
                    delegate: appsDelegate
                }

                displaced: Transition {
                    NumberAnimation {
                        properties: "x,y"
                        easing.type: Easing.OutQuad
                    }
                }

                // Scrollbar
                ScrollBar.horizontal:  ScrollBar {
                    id: scrollBar
                    parent: appsMenu.parent
                    height: 10
                    anchors {
                        left: parent.left
                        right: parent.right
                        bottom: parent.bottom
                    }
                    orientation: Qt.Horizontal
                    policy: ScrollBar.AlwaysOn
                    snapMode: ScrollBar.SnapOnRelease

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
            // End Listview for apps menu
            //--------------------------------------------------------------------//
        }
        //--------------------------------------------------------------------//
        // End Menu area
        //--------------------------------------------------------------------//

//    }
}
