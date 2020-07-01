import QtQuick 2.13
import QtQuick.Controls 2.13

Item {

    // Background Radio player area
    Rectangle {
        id: radioPlayerArea
        opacity: 0.5
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "#2B2E30" }
            GradientStop { position: 0.5; color: "#121213" }
            GradientStop { position: 1; color: "#2B2E30" }
        }

        // Hide virtual Keyboard
        MouseArea {
            anchors.fill: parent
            onClicked: {
                focus = true
            }
        }
    }

    // Radio FM title area
    Item {
        id: radioFMTitle
        width: parent.width
        height: 120

        // Radio icon
        Image {
            id: radioIcon
            source: "qrc:/Apps/Radio/images/radio.png"
            anchors {
                left: parent.left
                leftMargin: 30
                verticalCenter: parent.verticalCenter
            }
        }

        // Radio title
        Text {
            id: radioTitle
            text: "Radio FM"
            font.pixelSize: 40
            font.family: cantarell.name
            color: "#FFFFFF"
            anchors {
                left: radioIcon.right
                leftMargin: 20
                verticalCenter: parent.verticalCenter
            }
        }
    }

    //
    Item {
        id: wishlistChanelTitle
        width: parent.width
        height: 100
        anchors.top: radioFMTitle.bottom

        Text {
            id: chanelTitle
            text: "Xone FM"
            color: "#FFFFFF"
            font.pixelSize: 72
            font.family: cantarell.name
            anchors.centerIn: parent
        }
    }

    Item {
        id: frequencyItem
        width: parent.width
        height: 100
        anchors.top: wishlistChanelTitle.bottom

        Image {
            id: scanIcon
            source: "qrc:/Apps/Radio/images/scan_fm.png"
            anchors {
                left: parent.left
                leftMargin: 90
                verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: scanTitle
            text: "Scan FM"
            color: "#FFFFFF"
            font.pixelSize: 36
            font.family: cantarell.name
            anchors {
                left: scanIcon.right
                leftMargin: 20
                verticalCenter: parent.verticalCenter
            }
        }

        Text {
            id: currentFrequency
            text: "98.0" + " "
            color: "#FFFFFF"
            font.pixelSize: 72
            font.family: cantarell.name
            anchors.centerIn: parent
        }

        Text {
            id: mhzUnit
            text: "Mhz"
            color: "#bebebe"
            font.pixelSize: 48
            font.family: cantarell.name
            anchors {
                left: currentFrequency.right
                bottom: currentFrequency.bottom
            }
        }

        Image {
            id: favoriteIcon
            property var source_prefix: "qrc:/Apps/Radio/images/"
            source: scanTitle.text == "" ? source_frefix + "favorite.png"
                                         : source_prefix + "favorited.png"
            anchors {
                right: parent.right
                rightMargin: 90
                verticalCenter: parent.verticalCenter
            }
        }
    }

    Item {
        id: rangeChanelsContainer
        width: parent.width
        height: 340
        anchors.top: frequencyItem.bottom

        Image {
            id: arrowCurrentChanel
            source: "qrc:/Apps/Radio/images/arrow_current_chanel.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            id: rangeChanelsItem
            width: parent.width
            anchors {
                top: arrowCurrentChanel.bottom
                bottom: parent.bottom
            }

            Rectangle {
                id: lineCurrentChanel
                width: 4
                height: parent.height
                z: 1
                anchors.centerIn: parent

                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop { position: 0.0; color: "#007deef8" }
                    GradientStop { position: 0.5; color: "#7deef8" }
                    GradientStop { position: 1.0; color: "#007deef8" }
                }
            }
        }
    }

    Item {
        id: controlButton
        width: parent.width
        anchors {
            top: rangeChanelsContainer.bottom
            bottom: parent.bottom
        }

        Image {
            id: leftArrowIcon
            source: "qrc:/Apps/Radio/images/arrow_left.png"
            anchors {
                left: parent.left
                leftMargin: 350
                verticalCenter: parent.verticalCenter
            }
        }

        Image {
            id: playIcon
            source: "qrc:/Apps/Radio/images/play_circle.png"
            anchors.centerIn: parent
        }

        Image {
            id: rightArrowIcon
            source: "qrc:/Apps/Radio/images/arrow_right.png"
            anchors {
                right: parent.right
                rightMargin: 350
                verticalCenter: parent.verticalCenter
            }
        }
    }
}
