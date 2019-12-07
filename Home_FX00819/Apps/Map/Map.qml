import QtQuick 2.13
import QtQuick.Controls 2.13
import QtLocation 5.13
import QtPositioning 5.13
import QtGraphicalEffects 1.13

Item {
    id: mapItem

    Plugin {
        id: mapPlugin
        name: "mapboxgl"
    }

    MapQuickItem {
        id: marker
        anchorPoint.x: placeHolder.width / 2
        anchorPoint.y: placeHolder.height / 2
        coordinate: QtPositioning.coordinate(10.78, 106.703)
        sourceItem: Image {
            id: placeHolder
            source: "qrc:/Images/Map/place_holder.png"
            width: implicitWidth * 0.7
            height: implicitHeight * 0.7

            Image {
                source: "qrc:/Images/Map/car_icon.png"
                anchors.centerIn: placeHolder
                width: implicitWidth * 0.7
                height: implicitHeight * 0.7
            }
        }
    }

    Item {
        id: mapViewItem
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: guideItem.right
            right: parent.right
        }

        Map {
            id: mapView
            plugin: mapPlugin
            center: QtPositioning.coordinate(10.78, 106.703)
            zoomLevel: 15
            copyrightsVisible: false
            enabled: false
            anchors.fill: parent

            Component.onCompleted: {
                mapView.addMapItem(marker)
            }
        }

        Button {
            id: zoonIn
            width: 50
            height: 50
            text: "+"
            font.pixelSize: 30

            background: Rectangle {
                color: zoonIn.down ? "#d3d3d3" : "#FFFFFF"
            }

            anchors {
                bottom: zoonOut.top
                bottomMargin: 20
               horizontalCenter: zoonOut.horizontalCenter
            }

            onClicked: zoomInAnimation.restart()
        }

        Button {
            id: zoonOut
            width: 50
            height: 50
            text: "-"
            font.pixelSize: 30

            background: Rectangle {
                color: zoonOut.down ? "#d3d3d3" : "#FFFFFF"
            }

            anchors {
                left: parent.left
                leftMargin: 20
                bottom: parent.bottom
                bottomMargin: 20
            }

            onClicked: zoomOutAnimation.restart()
        }

        PropertyAnimation {
            id: zoomInAnimation
            target: mapView
            property: "zoomLevel"
            duration: 1000
            from: mapView.zoomLevel
            to: mapView.zoomLevel + 1
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation {
            id: zoomOutAnimation
            target: mapView
            property: "zoomLevel"
            duration: 1000
            from: mapView.zoomLevel
            to: mapView.zoomLevel - 1
        }
    }

    // Guide Area
    Item {
        id: guideItem
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: parent.width / 3.5

        // Guide background area
        Rectangle {
            id: guideBg
            color: "#FFFFFF"
            anchors.fill: parent
        }

        Item {
            id: placeChooseItem
            height: parent.height * 0.2
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            Rectangle {
                id: placeChooseBg
                color: "#6065EE"
                anchors.fill: parent
            }

            Image {
                id: currentLocationIcon
                source: "qrc:/Images/Map/current_location.png"
                anchors {
                    top: parent.top
                    topMargin: 40
                    left: parent.left
                    leftMargin: 30
                }
            }

            TextField {
                id: currentText
                placeholderText: qsTr("Choose starting location")
                font.pixelSize: 20
                color: "#515356"
                height: 50
                anchors {
                    left: currentLocationIcon.right
                    leftMargin: 30
                    right: parent.right
                    rightMargin: 30
                    verticalCenter: currentLocationIcon.verticalCenter
                }

                background: Rectangle {
                    color: "#FFFFFF"
                    border.color: "#D6D6D6"
                    radius: 4
                }
            }

            Image {
                id: placeHolderIcon
                source: "qrc:/Images/Map/location_sign.png"
                width: implicitWidth * 0.5
                height: implicitHeight * 0.5
                anchors {
                    bottom: parent.bottom
                    bottomMargin: 40
                    horizontalCenter: currentLocationIcon.horizontalCenter
                }
            }

            TextField {
                id: destinationText
                placeholderText: qsTr("Choose destination")
                font.pixelSize: 20
                color: "#515356"
                height: 50
                anchors {
                    left: placeHolderIcon.right
                    leftMargin: 30
                    right: parent.right
                    rightMargin: 30
                    verticalCenter: placeHolderIcon.verticalCenter
                }

                background: Rectangle {
                    color: "#FFFFFF"
                    border.color: "#D6D6D6"
                    radius: 4
                }
            }

            Column {
                id: dotColumn
                width: 5
                spacing: height / 5
                anchors {
                    top: currentLocationIcon.bottom
                    topMargin: dotColumn.width
                    bottom: placeHolderIcon.top
                    bottomMargin: dotColumn.width
                    horizontalCenter: currentLocationIcon.horizontalCenter
                }

                Rectangle {
                    color: "#CDE2FF"
                    width: parent.width
                    height: width
                    radius: 50
                }
                Rectangle {
                    color: "#CDE2FF"
                    width: parent.width
                    height: width
                    radius: 50
                }
                Rectangle {
                    color: "#CDE2FF"
                    width: parent.width
                    height: width
                    radius: 50
                }
            }

            DropShadow {
                anchors.fill: placeHolderIcon
                source: placeHolderIcon
                color: "#aa000000"
                radius: 10
                samples: 21
                verticalOffset: 2
            }
        }

        // Shadown for guide area on right edge
        DropShadow {
            anchors.fill: guideBg
            source: guideBg
            color: "#aa000000"
            radius: 20
            samples: 31
        }

        DropShadow {
            anchors.fill: placeChooseItem
            source: placeChooseItem
            color: "#aa000000"
            radius: 20
            samples: 31
        }
    }
}
