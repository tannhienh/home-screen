import QtQuick 2.13

DropArea {
    id: dropArea

    property int visualIndex: parent.visualIndex

    width: (appsMenu.width - (appsMenu.spacing * 5)) / 6
    height: appsMenu.height
    keys: "AppButton"
    anchors.verticalCenter: parent.verticalCenter

    onEntered: {
        if (drag.source.visualIndex !== appItem.visualIndex) {
            // Swap 2 apps icon in appsModel when drag
            appsModel.swap(drag.source.visualIndex,
                           appItem.visualIndex)

            // Move app icon to new position in visual listview
            visualModel.items.move(drag.source.visualIndex,
                                   appItem.visualIndex)
        }
    }

    // Binding property visualIndex of appItem
    // when visualIndex value of Delegate changed
    Binding {
        target: appItem
        property: "visualIndex"
        value: visualIndex
    }

    // App item include button, is object can drag
    Item {
        id: appItem

        property int visualIndex: 0

        anchors.fill: dropArea

        Drag.active: appButton.held
        Drag.source: dropArea
        Drag.keys: "AppButton"
        Drag.hotSpot.x: appButton.width / 2
        Drag.hotSpot.y: appButton.height / 2

        // Determine the direction of movement for scroll bar
        onXChanged: {
            if (x < 0) {
                menuArea.moveRight = false
                scrollTimer.running = true
            } else if ((x + appItem.width) > 1920) {
                menuArea.moveRight = true
                scrollTimer.running = true
            } else
                scrollTimer.running = false
        }

        Button {
            id: appButton

            property bool held: false

            property var appUrl:
                appsModel.data(appsModel.index(visualIndex, 0), 259)

            icon_src: appsModel.data(appsModel.index(visualIndex, 0), 260)
            button_title: appsModel.data(appsModel.index(visualIndex, 0), 258)
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            pressAndHoldInterval: statusBar.editting ? 500 : 1000

            drag.target: held ? appItem : undefined
            drag.axis: Drag.XAxis

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
                    if (statusBar.isShowEditButton)
                        statusBar.isShowEditButton = false

                    appsMenu.currentIndex = model.index

                    if (!appsMenuScope.focus)
                        appsMenuScope.focus = true

                    appButton.focus = true
                    appButton.state = "Pressed"
                }
            }

            onPressAndHold: {
                if (statusBar.editting === false)
                    statusBar.isShowEditButton = true

                if (statusBar.editting) {
                    appButton.focus = false
                    appItem.scale = 0.9
                    appButton.held = true
                    appsMenu.snapMode = ListView.NoSnap
                }
            }

            onReleased: {
                if (statusBar.editting) {
                    appItem.scale = 1.0
                    appButton.held = false
                    appsMenu.snapMode = ListView.SnapToItem
                } else {
                    appButton.state = "Focus"
                }
            }

            // Open app when app button was clicked
            onClicked: openApplication(appButton.appUrl)

            Keys.onReleased: {
                if (event.key === Qt.Key_Return
                        && statusBar.editting === false) {
                    statusBar.isShowEditButton = false
                    state = "Focus"
                    event.accepted = true
                    openApplication(appItem.appUrl)
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
                target: statusBar
                onEditButtonClicked: {
                    appButton.state = "Normal"
                }
                onDoneButtonClicked: appButton.held = false
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
