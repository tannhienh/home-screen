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

    FocusScope {
        anchors.fill: parent

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

                Keys.onRightPressed: console.log("tested")
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
                    focus: true
                    disable: true
                }
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
                    onClicked: openApplication("qrc:/Apps/MusicPlayer/qml/MusicPlayer.qml")
                }
            }
        }
        //--------------------------------------------------------------------//
        // End widgetsArea
        //--------------------------------------------------------------------//

        //--------------------------------------------------------------------//
        // Start Menu area
        //--------------------------------------------------------------------//
        Component {
            id: appsDelegate
            DropArea {
                id: delegateRoot
                width: icon.width
                height: icon.height
                keys: "Button"

                onEntered: visualModel.items.move(drag.source.visualIndex,
                                                  icon.visualIndex)

                property int visualIndex: DelegateModel.itemsIndex

                Binding {
                    target: icon
                    property: "visualIndex"
                    value: visualIndex
                }

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: appButton.width
                    height: appButton.height
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    Button{
                        id: appButton
                        anchors.fill: parent
                        button_title: appsModel.data(appsModel.index(icon.visualIndex, 0), 257)
                        icon_src: appsModel.data(appsModel.index
                                                 (icon.visualIndex, 0), 259)
                        onClicked: {
                            openApplication(appsModel.data(appsModel.index(icon.visualIndex, 0), 258))
                        }

                        onReleased: {
                            appButton.focus = true
                            appButton.state = "Focus"
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex)
                                    visualModel.items.get(index).focus = false
                                else
                                    visualModel.items.get(index).focus = true
                            }
                        }
                    }

                    onFocusChanged: appButton.focus = icon.focus

                    Drag.active: appButton.drag.active
                    Drag.keys: "Button"

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }
        // End Component Delegate

        // Listview for apps menu
        ListView {
            id: menu

            orientation: ListView.Horizontal
            interactive: false
            clip: true
            snapMode: ListView.SnapToItem
            spacing: 22

            anchors {
                top: widgetsArea.bottom
                topMargin: 10
                left: parent.left
                leftMargin: 20
                right: parent.right
                rightMargin: 20
                bottom: parent.bottom
            }

            model: DelegateModel {
                id: visualModel
                model: appsModel
                delegate: appsDelegate
            }

            // Scrollbar
            ScrollBar.horizontal:  ScrollBar {
                parent: menu.parent
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
        // End Menu area
        //--------------------------------------------------------------------//
    }
}
