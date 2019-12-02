import QtQuick 2.0
import QtLocation 5.13
import QtPositioning 5.13

Item {
    id: mapItem

    Plugin {
        id: mapPlugin
        name: "mapboxgl"
    }

    MapQuickItem {
        id: marker
        anchorPoint.x: carIcon.width / 2
        anchorPoint.y: carIcon.height / 2
        coordinate: QtPositioning.coordinate(10.78, 106.703)
        sourceItem: Image {
            id: carIcon
            source: "qrc:/Images/Map/car_icon.png"
        }
    }

    Map {
        id: mapView
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(10.78, 106.703)
        zoomLevel: 15
        copyrightsVisible: false
        enabled: false
        Component.onCompleted: {
            mapView.addMapItem(marker)
        }
    }
}
