import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13

Drawer {
    id: settingsMennu
    interactive: false
    modal: false

    // Velocity of transition for enter and exit Settings
    enter: Transition { SmoothedAnimation { velocity: 2 } }
    exit: Transition { SmoothedAnimation { velocity: 2 } }

    // background Settings Menu
    background: Rectangle {
        width: parent.width - 4
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: "#502B2E30" }
            GradientStop { position: 1; color: "#504A4A4A" }
        }
    }

    // Hide virtual Keyboard
    MouseArea {
        anchors.fill: parent
        onClicked: {
            focus = true
        }
    }

    // Settings menu container
    Item {
        id: drawerItem
        width: parent.width - 4
        height: parent.height

        // Background for Settings title
        Rectangle {
            id: bgSettingsMenuTitle
            width: parent.width
            height: 117
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0; color: "#2B2E30" }
                GradientStop { position: 1; color: "#4A4A4A" }
            }

            // Settings icon
            Item {
                id: settingsTitleIcon
                width: 160
                height: parent.height

                Image {
                    source: "qrc:/Apps/Settings/images/settings.png"
                    anchors.centerIn: parent
                }
            }

            // Settings menu title
            Text {
                text: qsTr("Settings")
                font.pixelSize: 48
                font.family: ubuntu.name
                color: "#FFFFFF"
                anchors {
                    left: settingsTitleIcon.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // Horizontal line at the bottom Wishlist background
        Rectangle {
            id: lineBottomSettingsMenu
            width: parent.width
            height: 3
            color: "#5d6164"
            anchors.top: bgSettingsMenuTitle.bottom
        }

        // Drop shadow for horizontal line bottom Settings Menu background
        DropShadow {
            anchors.fill: lineBottomSettingsMenu
            source: lineBottomSettingsMenu
            color: "#000000"
            verticalOffset: 2
            radius: 5
            opacity: 0.5
        }

        ListModel {
            id: settingsMenuModel

            ListElement {
                SettingTitle: "General settings"
                SettingIcon: "general_settings.png"
            }

            ListElement {
                SettingTitle: "Driving mode"
                SettingIcon: "driving_mode.png"
            }

            ListElement {
                SettingTitle: "Lighting"
                SettingIcon: "lighting.png"
            }

            ListElement {
                SettingTitle: "Driver assistance"
                SettingIcon: "driver_assistance.png"
            }

            ListElement {
                SettingTitle: "Display"
                SettingIcon: "display.png"
            }

            ListElement {
                SettingTitle: "Door/Vehicle access"
                SettingIcon: "door_vehicle_access.png"
            }

            ListElement {
                SettingTitle: "Key button assignment"
                SettingIcon: "key_button_assignment.png"
            }

            ListElement {
                SettingTitle: "Vehicle status"
                SettingIcon: "vehicle_status.png"
            }
        }

        Component {
            id: settingsMenuDelegate

            MouseArea {
                id: mouseAreaItem

                width: parent.width
                height: 112


                // Icon for each setting category
                Item {
                    id: settingCategoryIcon
                    width: 100
                    height: parent.height

                    Image {
                        source: "qrc:/Apps/Settings/images/" + SettingIcon
                        anchors.centerIn: parent
                    }
                }

                Text {
                    id: settingCategoryTitle
                    text: SettingTitle
                    color: "#FFFFFF"
                    font.pixelSize: 40
                    font.family: ubuntu.name
                    anchors {
                        left: settingCategoryIcon.right
                        verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    id: lineBottomItem
                    width: parent.width
                    height: 3
                    anchors.bottom: parent.bottom
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop {
                            position: 0.0;
                            color: "#00474747"
                        }
                        GradientStop {
                            position: 0.5;
                            color: "#a4a4a4"
                        }
                        GradientStop {
                            position: 1.0;
                            color: "#00474747"
                        }
                    }
                }

                // change current index in playlist of player when playlist change
                // current index
                onClicked: {
                    if (listViewSettingsMenu.currentIndex != index) {
                        listViewSettingsMenu.currentIndex = index
                    }
                }
            }
        }

        Component {
            id: highlightItem

            Item {
                z: 1000
                height: parent.height
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Rectangle {
                    id: lineHighlightTop
                    width: parent.width
                    height: 3
                    anchors.top: parent.top
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#007deef8" }
                        GradientStop { position: 0.5; color: "#7deef8" }
                        GradientStop { position: 1.0; color: "#007deef8" }
                    }
                }

                Rectangle {
                    width: parent.width
                    anchors.top: lineHighlightTop.bottom
                    anchors.bottom: lineHighlightBottom.top
                    gradient: Gradient {
                        orientation: Gradient.Vertical
                        GradientStop { position: 0.0; color: "#5000eaff" }
                        GradientStop { position: 0.3; color: "#007deef8" }
                        GradientStop { position: 0.85; color: "#007deef8" }
                        GradientStop { position: 1.0; color: "#5000eaff" }
                    }
                }

                Rectangle {
                    id: lineHighlightBottom
                    width: parent.width
                    height: 3
                    anchors.bottom: parent.bottom
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#007deef8" }
                        GradientStop { position: 0.5; color: "#7deef8" }
                        GradientStop { position: 1.0; color: "#007deef8" }
                    }
                }
            }
        }

        // List View settings menu
        ListView {
            id: listViewSettingsMenu
            width: parent.width
            anchors {
                top: lineBottomSettingsMenu.bottom
                bottom: parent.bottom
            }
            model: settingsMenuModel
            delegate: settingsMenuDelegate
            clip: true
            snapMode: ListView.SnapToItem
//            highlightMoveDuration: 900
            highlightMoveVelocity: 1000
            highlight: highlightItem
            // Scrollbar for list view settings menu
            ScrollBar.vertical: ScrollBar {
                parent: listViewSettingsMenu.parent
                width: 10
                snapMode: ScrollBar.SnapOnRelease
                anchors {
                    top: listViewSettingsMenu.top
                    left: listViewSettingsMenu.right
                    leftMargin: 4
                    bottom: listViewSettingsMenu.bottom
                }
            }
        }
    }

    // Vertical line right side settings menu
    Rectangle {
        id: line
        width: 4
        height: parent.height
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop { position: 0.0; color: "#7a7a7a" }
            GradientStop { position: 0.5; color: "#cccccc" }
            GradientStop { position: 1.0; color: "#7a7a7a" }
        }
        anchors.left: drawerItem.right
    }
}
