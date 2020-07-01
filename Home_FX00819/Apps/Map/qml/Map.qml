import QtQuick 2.13
import QtPositioning 5.13
import Qt.labs.settings 1.1

Item {
    id: mapApp

    // Cordinate location default when load map
    property var locationDefault: QtPositioning.coordinate(10.78, 106.703)

    // Hold the active of car moving or parking
    property bool carMoving: true

    // Values for supportedMapTypes
    readonly property int lightMap: 0
    readonly property int satelliteMap: 5
    readonly property int darkMap: 7

    // Storage settings for map application
    Settings {
        id: mapSettings
        property int mapType: 7
        property int tilt: 0
        property bool showExploreLocations: true
    }

    // Font Cantarell
    FontLoader {
        id: cantarell
        source: "qrc:/Fonts/Cantarell-Regular.ttf"
    }

    // Area display map view
    MapView {
        id: mapView

        width: parent.width - guideItem.width

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
    }

    GuideArea {
        id: guideItem
        width: 550
        height: parent.height
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }
    }
}
