import QtQuick 2.13
import QtLocation 5.13
import QtPositioning 5.13

Item {
    id: map

    Plugin {
        id: mapPlugin
        name: "mapboxgl"
    }

    Map {
        id: mapView
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(10.78, 106.703)
        zoomLevel: 15
        copyrightsVisible: false
        Component.onCompleted: {
            mapView.addMapItem(marker)
        }
    }

    MapQuickItem {
        id: marker
        anchorPoint.x: placeHolder.width / 2
        anchorPoint.y: placeHolder.height / 2
        coordinate: QtPositioning.coordinate(10.78, 106.703)
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
