import QtQuick 2.13
import QtLocation 5.13
import QtPositioning 5.13

// Javascript common function
import "../Js/Common.js" as Common

FocusScope {
    id: map

    property alias stateHighLight: mapHighlight.state

    Rectangle {
        color: "transparent"
        anchors.fill: parent

        // Cordinate location default when load map
        property var locationDefault: QtPositioning.coordinate(10.78, 106.703)

        Plugin {
            id: mapPlugin
            name: "mapboxgl"
        }

        // Getting current Position of device
        // Update interval 1 second
        PositionSource {
            id: positionSource
            active: true
            updateInterval: 1000 // 1 second
            onPositionChanged: {
                var currentPosition = positionSource.position.coordinate
                mapView.center = currentPosition
                marker.coordinate = currentPosition
            }
        }

        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: locationDefault
            zoomLevel: 17.5
            copyrightsVisible: false
            enabled: false
            bearing: 13
            activeMapType: supportedMapTypes[7]
            tilt: maximumTilt
            Component.onCompleted: {
                mapView.addMapItem(marker)
            }
        }

        MapQuickItem {
            id: marker
            anchorPoint.x: placeHolder.width / 2
            anchorPoint.y: placeHolder.height / 2
            coordinate: locationDefault
            sourceItem: Image {
                id: placeHolder
                source: "qrc:/Images/Map/place_holder.png"

                Image {
                    source: "qrc:/Images/Map/car_icon.png"
                    anchors.centerIn: placeHolder
                }
            }
        }
    }

    WidgetHighlight {
        id: mapHighlight
        anchors.fill: parent
        onClicked: Common.openApp("qrc:/Apps/Map/qml/Map.qml")
    }
}
