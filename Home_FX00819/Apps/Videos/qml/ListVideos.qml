import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13

Drawer {
    id: listVideosDrawer
    interactive: false
    modal: false

    // Velocity of transition for enter and exit list videos
    enter: Transition { SmoothedAnimation { velocity: 2 } }
    exit: Transition { SmoothedAnimation { velocity: 2 } }

    // background list videos area
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

    // List videos container
    Item {
        id: drawerItem
        width: parent.width - 4
        height: parent.height

        // Background for my videos title
        Rectangle {
            id: bgMyVideos
            width: parent.width
            height: 117
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0; color: "#2B2E30" }
                GradientStop { position: 1; color: "#4A4A4A" }
            }

            // Video icon
            Item {
                id: videoIcon
                width: 160
                height: parent.height

                Image {
                    source: "qrc:/Apps/Videos/images/video_icon.png"
                    anchors.centerIn: parent
                }
            }

            // My videos title
            Text {
                text: qsTr("My Videos")
                font.pixelSize: 48
                font.family: ubuntu.name
                color: "#FFFFFF"
                anchors {
                    left: videoIcon.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // Horizontal line at the bottom My videos background
        Rectangle {
            id: lineBottomMyVideos
            width: parent.width
            height: 3
            color: "#5d6164"
            anchors.top: bgMyVideos.bottom
        }

        // Search Video item
        Item {
            id: searchItem
            width: parent.width
            height: 95
            anchors.top: lineBottomMyVideos.bottom

            // Search icon
            Item {
                id: searchIcon
                width: 100
                height: parent.height
                Image {
                    source: "qrc:/Apps/Videos/images/search_icon.png"
                    anchors.centerIn: parent
                }

                // Vertical line seperate search icon and search input field
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

            // Search input field
            TextField {
                id: searchField
                height: parent.height
                color: "#FFFFFF"
                placeholderText: qsTr("Search...")
                font.pixelSize: 36
                font.family: ubuntu.name
                selectByMouse: true
                selectedTextColor: color
                selectionColor: "#503498DB"
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

            // Horizontal line at the bottom search item
            Rectangle {
                id: lineBottomSearch
                width: parent.width
                height: 3
                anchors.bottom: parent.bottom
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#474747" }
                    GradientStop { position: 0.5; color: "#a4a4a4" }
                    GradientStop { position: 1.0; color: "#474747" }
                }
            }
        }

        // My videos model
        ListModel {
            id: myVideosModel

            ListElement {
                VideoName: "Video 1"
                TotalTime: "4:30"
            }

            ListElement {
                VideoName: "Video 2"
                TotalTime: "5:20"
            }

            ListElement {
                VideoName: "Video 1"
                TotalTime: "4:30"
            }

            ListElement {
                VideoName: "Video 2"
                TotalTime: "5:20"
            }

            ListElement {
                VideoName: "Video 1"
                TotalTime: "4:30"
            }

            ListElement {
                VideoName: "Video 2"
                TotalTime: "5:20"
            }

            ListElement {
                VideoName: "Video 1"
                TotalTime: "4:30"
            }

            ListElement {
                VideoName: "Video 2"
                TotalTime: "5:20"
            }
        }

        // My Videos Delegate
        Component {
            id: myVideosDelegate

            Item {
                width: parent.width
                height: 130

                // Video thumbnail
                Item {
                    id: videoThumbnailItem
                    width: 150
                    anchors {
                        top: parent.top
                        topMargin: 10
                        left: parent.left
                        leftMargin: 5
                        bottom: parent.bottom
                        bottomMargin: 10
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: "Transparent"
                        border {
                            width: 2
                            color: "#808080"
                        }

                        Image {
                            id: videoThumbnail
                            source: "qrc:/Apps/Videos/images/video_icon.png"
                            anchors.centerIn: parent
                        }
                    }
                }

                // Video name
                Text {
                    id: videoName
                    text: VideoName
                    color: "#FFFFFF"
                    font.pixelSize: 48
                    font.family: ubuntu.name
                    anchors {
                        left: videoThumbnailItem.right
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                }

                // Total time of video
                Text {
                    id: totalTime
                    text: TotalTime
                    color: "#bebebe"
                    font.pixelSize: 36
                    font.family: ubuntu.name
                    anchors {
                        right: parent.right
                        rightMargin: 20
                        bottom: videoName.bottom
                    }
                }

                Rectangle {
                    id: lineBottomItem
                    width: parent.width
                    height: 3
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
            id: listViewMyVideos
            width: parent.width
            anchors {
                top: searchItem.bottom
                bottom: parent.bottom
            }
            model: myVideosModel
            delegate: myVideosDelegate
            clip: true
            snapMode: ListView.SnapToItem

            // Scrollbar for list My Videos
            ScrollBar.vertical: ScrollBar {
                parent: listViewMyVideos.parent
                width: 10
                snapMode: ScrollBar.SnapOnRelease
                anchors {
                    top: listViewMyVideos.top
                    left: listViewMyVideos.right
                    leftMargin: 4
                    bottom: listViewMyVideos.bottom
                }
            }
        }

        // Drop shadow for horizontal line bottom My videos background
        DropShadow {
            anchors.fill: lineBottomMyVideos
            source: lineBottomMyVideos
            color: "#000000"
            verticalOffset: 2
            radius: 5
            opacity: 0.5
        }
    }

    // Vertical line right side list My videos area
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
