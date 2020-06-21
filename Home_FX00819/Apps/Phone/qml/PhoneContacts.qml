import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13
import QtQuick.VirtualKeyboard 2.13


Drawer {
    id: phoneContacts
    interactive: false
    modal: false

    // Velocity of transition for enter and exit playlist
    enter: Transition { SmoothedAnimation { velocity: 2 } }
    exit: Transition { SmoothedAnimation { velocity: 2 } }

    // Font Ubuntu
    FontLoader {
        id: ubuntu
        source: "qrc:/Fonts/Ubuntu-Regular.ttf"
    }

    // background
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

    Item {
        id: drawerItem
        width: parent.width - 4
        height: parent.height

        TabBar {
            id: phoneTab
            width: parent.width
            height: 117
            spacing: 0

            TabButton {
                id: recentsTab
                height: 117
                anchors.top: parent.top

                contentItem:  Item {
                    opacity: phoneTab.currentIndex == 0 ? 1 : 0.5
                    Item {
                        id: recentsIcon
                        width: 100
                        height: parent.height

                        Image {
                            source: "qrc:/Apps/Phone/images/recents.png"
                            anchors.centerIn: parent
                        }
                    }

                    Text {
                        text: "Recents"
                        color: "#FFFFFF"
                        font.pixelSize: 48
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors {
                            left: recentsIcon.right
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }

                background: Rectangle {
                    gradient: Gradient {
                        orientation: Gradient.Vertical
                        GradientStop { position: 0; color: phoneTab.currentIndex == 0 ? "#2B2E30" : "#1e2122" }
                        GradientStop { position: 1; color: phoneTab.currentIndex == 0 ? "#4A4A4A" : "#333334" }
                    }
                }
            }

            TabButton {
                id: contactsTab
                height: 117
                anchors.top: parent.top

                contentItem:  Item {
                    opacity: phoneTab.currentIndex == 1 ? 1 : 0.5
                    Item {
                        id: contactsIcon
                        width: 100
                        height: parent.height

                        Image {
                            source: "qrc:/Apps/Phone/images/contacts.png"
                            anchors.centerIn: parent
                        }
                    }

                    Text {
                        text: "Contacts"
                        color: "#FFFFFF"
                        font.pixelSize: 48
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors {
                            left: contactsIcon.right
                            verticalCenter: parent.verticalCenter
                        }
                    }
                }

                background: Rectangle {
                    gradient: Gradient {
                        orientation: Gradient.Vertical
                        GradientStop { position: 0; color: phoneTab.currentIndex == 1 ? "#2B2E30" : "#1e2122" }
                        GradientStop { position: 1; color: phoneTab.currentIndex == 1 ? "#4A4A4A" : "#333334" }
                    }
                }
            }
        }

        Rectangle {
            id: lineBottomTab
            width: parent.width
            height: 3
            color: "#5d6164"
            anchors.top: phoneTab.bottom
        }

        Item {
            id: searchItem
            width: parent.width
            height: 90
            anchors.top: lineBottomTab.bottom

            Item {
                id: searchIcon
                width: 100
                height: parent.height
                Image {
                    source: "qrc:/Apps/Phone/images/search_icon.png"
                    anchors.centerIn: parent
                }

                Rectangle {
                    width: 3
                    height: 48
                    color: "#FFFFFF"
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }
                }
            }

            TextField {
                id: searchField
                height: parent.height
                color: "#FFFFFF"
                placeholderText: qsTr("Search...")
                font.pixelSize: 36
                font.family: ubuntu.name
                background: Rectangle {
                    opacity: 0
                }

                anchors {
                    left: searchIcon.right
                    leftMargin: 15
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: lineBottomSearch
                width: parent.width
                height: 2
                anchors.bottom: parent.bottom
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#474747" }
                    GradientStop { position: 0.5; color: "#a4a4a4" }
                    GradientStop { position: 1.0; color: "#474747" }
                }
            }
        }

        StackLayout {
            id: tabContents
            width: parent.width
            currentIndex: phoneTab.currentIndex
            anchors {
                top: searchItem.bottom
                bottom: parent.bottom
            }

            ListRecents {
                id: listRecents
            }

            ListContacts {
                id: listContacts
            }
        }

        DropShadow {
            anchors.fill: lineBottomTab
            source: lineBottomTab
            color: "#000000"
            verticalOffset: 2
            radius: 5
            opacity: 0.5
        }
    }

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
