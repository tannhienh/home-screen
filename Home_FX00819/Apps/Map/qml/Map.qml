import QtQuick 2.13
import QtLocation 5.13
import QtPositioning 5.13
import QtQuick.Controls 2.13
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
            source: "qrc:/Apps/Map/images/place_holder.png"

            Image {
                source: "qrc:/Apps/Map/images/car_icon.png"
                anchors.centerIn: placeHolder
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

        Rectangle {
            id: locateButton
            width: 50
            height: 50
            color: "#FFFFFF"
            radius: 50

            anchors {
                bottom: zoomIn.top
                bottomMargin: 20
                horizontalCenter: zoomIn.horizontalCenter
            }

            Image {
                source: "qrc:/Apps/Map/images/current_location.png"
                anchors.centerIn: locateButton
            }

            MouseArea {
                anchors.fill: parent
                onPressed: locateButton.color = "#d3d3d3"
                onReleased: locateButton.color = "#FFFFFF"
            }
        }

        Button {
            id: zoomIn
            width: 50
            height: 50
            text: "+" // color: #292A2F
            font.pixelSize: 30

            background: Rectangle {
                color: zoomIn.down ? "#d3d3d3" : "#FFFFFF"
            }

            anchors {
                bottom: zoomOut.top
                bottomMargin: 20
                horizontalCenter: zoomOut.horizontalCenter
            }

            onClicked: zoomInAnimation.restart()
        }

        Button {
            id: zoomOut
            width: 50
            height: 50
            text: "-" // color: #292A2F
            font.pixelSize: 30

            background: Rectangle {
                color: zoomOut.down ? "#d3d3d3" : "#FFFFFF"
            }

            anchors {
                left: parent.left
                leftMargin: 20
                bottom: parent.bottom
                bottomMargin: 20
            }

            onClicked: zoomOutAnimation.restart()
        }

        DropShadow {
            anchors.fill: locateButton
            source: locateButton
            color: "#aa000000"
            radius: 20
            samples: 31
        }

        DropShadow {
            anchors.fill: zoomIn
            source: zoomIn
            color: "#aa000000"
            radius: 20
            samples: 31
        }

        DropShadow {
            anchors.fill: zoomOut
            source: zoomOut
            color: "#aa000000"
            radius: 20
            samples: 31
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

    GuideArea {
        id: guideItem
        width: parent.width / 3.5
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }
    }
}
