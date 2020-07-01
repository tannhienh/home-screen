import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13

Drawer {
    id: wishlistDrawer
    interactive: false
    modal: false

    // Velocity of transition for enter and exit wishlist
    enter: Transition { SmoothedAnimation { velocity: 2 } }
    exit: Transition { SmoothedAnimation { velocity: 2 } }

    // background phone contacts area
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

    // Phone contacts container
    Item {
        id: drawerItem
        width: parent.width - 4
        height: parent.height

        // Background for Wishlist title
        Rectangle {
            id: bgWishlist
            width: parent.width
            height: 117
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0; color: "#2B2E30" }
                GradientStop { position: 1; color: "#4A4A4A" }
            }

            // Wishlist icon
            Item {
                id: wishlistIcon
                width: 160
                height: parent.height

                Image {
                    source: "qrc:/Apps/Radio/images/wishlist.png"
                    anchors.centerIn: parent
                }
            }

            // Wish list chanel title
            Text {
                text: qsTr("Wishlist chanels")
                font.pixelSize: 48
                font.family: cantarell.name
                color: "#FFFFFF"
                anchors {
                    left: wishlistIcon.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // Horizontal line at the bottom Wishlist background
        Rectangle {
            id: lineBottomWishlist
            width: parent.width
            height: 3
            color: "#5d6164"
            anchors.top: bgWishlist.bottom
        }

        // Drop shadow for horizontal line bottom Wishlist background
        DropShadow {
            anchors.fill: lineBottomWishlist
            source: lineBottomWishlist
            color: "#000000"
            verticalOffset: 2
            radius: 5
            opacity: 0.5
        }

        ListModel {
            id: wishlistChanelsModel

            ListElement {
                ChanelName: "Xone FM"
                Frequency: "98"
            }

            ListElement {
                ChanelName: "VOV GT"
                Frequency: "95.6"
            }
        }

        Component {
            id: wishlistChanelDelegate

            Item {
                width: parent.width
                height: 130

                Text {
                    id: chanelName
                    text: ChanelName
                    color: "#FFFFFF"
                    font.pixelSize: 48
                    font.family: cantarell.name
                    anchors {
                        left: parent.left
                        leftMargin: 20
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: frequency
                    text: Frequency
                    color: "#bebebe"
                    font.pixelSize: 45
                    font.family: cantarell.name
                    anchors {
                        left: parent.left
                        leftMargin: parent.width * 0.6
                        verticalCenter: parent.verticalCenter
                    }
                }

                Text {
                    id: mhzUnit
                    text: " Mhz"
                    color: "#bebebe"
                    font.pixelSize: 30
                    font.family: cantarell.name
                    anchors {
                        left: frequency.right
                        bottom: frequency.bottom
                    }
                }

                Image {
                    id: deleteIcon
                    source: "qrc:/Apps/Radio/images/delete.png"
                    anchors {
                        right: parent.right
                        rightMargin: 20
                        verticalCenter: parent.verticalCenter
                    }
                }

                Rectangle {
                    id: lineBottomItem
                    width: parent.width
                    height: 2
                    anchors.bottom: parent.bottom
                    gradient: Gradient {
                        orientation: Gradient.Horizontal
                        GradientStop { position: 0.0; color: "#00474747" }
                        GradientStop { position: 0.5; color: "#a4a4a4" }
                        GradientStop { position: 1.0; color: "#00474747" }
                    }
                }
            }
        }

        ListView {
            id: listViewWishlistChanels
            width: parent.width
            anchors {
                top: lineBottomWishlist.bottom
                bottom: parent.bottom
            }
            model: wishlistChanelsModel
            delegate: wishlistChanelDelegate
            clip: true
            snapMode: ListView.SnapToItem

            // Scrollbar for list recents
            ScrollBar.vertical: ScrollBar {
                parent: listViewWishlistChanels.parent
                width: 10
                snapMode: ScrollBar.SnapOnRelease
                anchors {
                    top: listViewWishlistChanels.top
                    left: listViewWishlistChanels.right
                    leftMargin: 4
                    bottom: listViewWishlistChanels.bottom
                }
            }
        }
    }

    // Vertical line right side phone contacts area
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
