import QtQuick 2.13
import QtLocation 5.13
import QtPositioning 5.13
import Qt.labs.settings 1.1
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13
import QtQuick.VirtualKeyboard 2.13

Item {
    id: mapItem

    // Cordinate location default when load map
    property var locationDefault: QtPositioning.coordinate(10.78, 106.703)

    // Hold the active of car moving or parking
    property bool carMoving: false

    // Values for supportedMapTypes
    readonly property int lightMap: 0
    readonly property int satelliteMap: 5
    readonly property int darkMap: 7

    // Storage settings for map application
    Settings {
        id: mapSettings
        property int mapType: 7
        property int tilt: 0
    }

    // Map plugin
    Plugin {
        id: mapPlugin
        name: "mapboxgl"
    }

    // Getting current Position of device
    // Update interval 1 second
    PositionSource {
        id: positionSource
        active: carMoving
        updateInterval: 1000
        onPositionChanged:  {
            var currentCoordinate = positionSource.position.coordinate
            mapView.center = currentCoordinate
            marker.coordinate = currentCoordinate
        }
    }

    // Area display map view
    Item {
        id: mapViewItem

        width: parent.width - guideItem.width

        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }

        // Map view
        Map {
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: locationDefault
            activeMapType: supportedMapTypes[mapSettings.mapType]
            zoomLevel: 17
            bearing: 13
            tilt: mapSettings.tilt
            copyrightsVisible: false
            Component.onCompleted: {
                mapView.addMapItem(marker)
            }

            // Hide virtual Keyboard
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    focus = true
                }
            }
        }

        // Button choose map type
        Button {
            id: mapTypeButton
            width: 75
            height: 75
            font.pixelSize: 30
            layer.enabled: true
            layer.effect: dropShadow

            anchors {
                left: parent.left
                leftMargin: 20
                top: parent.top
                topMargin: 20
            }

            background: OpacityMask {
                anchors.fill: mapTypeIcon
                source: mapTypeIcon
                maskSource: mask
            }

            // Map type icon
            Image {
                id: mapTypeIcon
                source: if (mapSettings.mapType == lightMap)
                            return "qrc:/Apps/Map/images/map_type_light.png"
                        else if (mapSettings.mapType == satelliteMap)
                            return "qrc:/Apps/Map/images/map_type_satellite.png"
                        else if (mapSettings.mapType == darkMap)
                            return "qrc:/Apps/Map/images/map_type_dark.png"
                visible: false
            }

            // Mask for map type icon
            Rectangle {
                id: mask
                anchors.fill: parent
                radius: 8
                visible: false
            }

            // Border for map type icon
            Rectangle {
                id: border
                anchors.fill: parent
                color: "Transparent"
                border.width: 3
                border.color: "#7deef8"
                radius: 5
            }

            // Show or hide map type menu when click map type icon
            onClicked: menuMapType.width === 0 ? showMenuMapType.restart()
                                               : hideMenuMapType.restart()

            // Hide menu types of map if focus to other
            onFocusChanged: if (!focus)
                                hideMenuMapType.restart()
        }

        // Menu map type
        Rectangle {
            id: menuMapType
            height: 180
            layer.enabled: true
            layer.effect: dropShadow

            anchors {
                top: parent.top
                topMargin: 20
                left: mapTypeButton.right
                leftMargin: 5
            }

            Column {
                anchors.fill: parent

                // Dark type map
                Button {
                    id: darkButton
                    width: parent.width
                    height: (parent.height - 2) / 3

                    // Save map type darkMap to mapSettings
                    onClicked: mapSettings.mapType = darkMap

                    // Map type icon
                   Image {
                        id: darkMapIcon
                        source: "qrc:/Apps/Map/images/map_type_dark.png"
                        width: parent.width / 3
                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                        }
                    }

                   // Label dark button
                   Text {
                       text: "Dark"
                       font.bold: true
                       font.pixelSize: 20
                       anchors {
                           left: darkMapIcon.right
                           leftMargin: 10
                           verticalCenter: parent.verticalCenter
                       }
                   }
                }

                // Line
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#BBBBBB"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Light type map
                Button {
                    id: lightButton
                    width: parent.width
                    height: (parent.height - 2) / 3

                    // Save map type lightMap to mapSettings
                    onClicked: mapSettings.mapType = lightMap

                    // Map type icon
                   Image {
                        id: lightMapIcon
                        source: "qrc:/Apps/Map/images/map_type_light.png"
                        width: parent.width / 3
                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                        }
                    }

                   // Label light button
                   Text {
                       text: "Light"
                       font.bold: true
                       font.pixelSize: 20
                       anchors {
                           left: lightMapIcon.right
                           leftMargin: 10
                           verticalCenter: parent.verticalCenter
                       }
                   }
                }

                // Line
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#BBBBBB"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Satellite type map
                Button {
                    id: satelliteButton
                    width: parent.width
                    height: (parent.height - 2) / 3

                    // Save map type satelliteMap to mapSettings
                    onClicked: mapSettings.mapType = satelliteMap

                    // Map type icon
                   Image {
                        id: satelliteMapIcon
                        source: "qrc:/Apps/Map/images/map_type_satellite.png"
                        width: parent.width / 3
                        anchors {
                            top: parent.top
                            left: parent.left
                            bottom: parent.bottom
                        }
                    }

                   // Label dark button
                   Text {
                       text: "Satellite"
                       font.bold: true
                       font.pixelSize: 20
                       anchors {
                           left: satelliteMapIcon.right
                           leftMargin: 10
                           verticalCenter: parent.verticalCenter
                       }
                   }
                }
            }
        }

        // Slider
        Slider {
            id: tiltSlider
            height: parent.height / 3
            orientation : Qt.Vertical
            from: mapView.minimumTilt
            to: mapView.maximumTilt
            value: mapSettings.tilt
            layer.enabled: true
            layer.effect: dropShadow

            // Save value tilt of map to map Settings
            onValueChanged: mapSettings.tilt = value

            anchors {
                top: mapTypeButton.bottom
                topMargin: 20
                left: parent.left
                leftMargin: 20
            }

            // Change background color of the slider when change map type
            background: Rectangle {
                width: 8
                height: tiltSlider.availableHeight
                radius: 6
                color: "#7DEEF8"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    width: 8
                    height: tiltSlider.visualPosition * parent.height
                    radius: 6
                    color: if (mapSettings.mapType == lightMap)
                            return "#777777"
                        else
                            return "#E4E4E4"
                }
            }
        }

        // Label for Tilt slider
        Text {
            id: tiltLabel
            text: "TILT"
            font.bold: true
            font.pixelSize: 20
            color: "#7DEEF8"
            layer.enabled: true
            layer.effect: dropShadow
            anchors {
                top: tiltSlider.bottom
                topMargin: 10
                horizontalCenter: tiltSlider.horizontalCenter
            }
        }

        // Marker car curent location on map
        MapQuickItem {
            id: marker
            anchorPoint.x: placeHolder.width / 2
            anchorPoint.y: placeHolder.height / 2
            coordinate: locationDefault
//            layer.enabled: true
//            layer.effect: dropShadow
            sourceItem: Image {
                id: placeHolder
                source: "qrc:/Apps/Map/images/place_holder.png"

                Image {
                    source: "qrc:/Apps/Map/images/car_icon.png"
                    anchors.centerIn: placeHolder
                }
            }
        }

        Rectangle {
            id: locateButton
            width: 50
            height: 50
            color: "#FFFFFF"
            radius: 50
            layer.enabled: true
            layer.effect: dropShadow

            anchors {
                bottom: zoomIn.top
                bottomMargin: 20
                horizontalCenter: zoomIn.horizontalCenter
            }

            Image {
                source: "qrc:/Apps/Map/images/current_location.png"
                anchors.centerIn: locateButton
                width: implicitWidth * 0.7
                height: implicitHeight * 0.7
            }

            MouseArea {
                anchors.fill: parent
                onPressed: locateButton.color = "#d3d3d3"
                onReleased: locateButton.color = "#FFFFFF"
                onClicked: locateAnimation.restart()
            }
        }

        Button {
            id: zoomIn
            width: 50
            height: 50
            text: "+" // color: #292A2F
            font.pixelSize: 30
            layer.enabled: true
            layer.effect: dropShadow

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
            layer.enabled: true
            layer.effect: dropShadow

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

        // Drop shadow for items
        Component {
            id: dropShadow
            DropShadow {
                color: "#aa000000"
                radius: 10
                samples: 21
            }
        }

        // Animation display center for current location
        PropertyAnimation {
            id: locateAnimation
            target: mapView
            property: "center"
            duration: 500
            from: mapView.center
            to: marker.coordinate
        }

        PropertyAnimation {
            id: zoomInAnimation
            target: mapView
            property: "zoomLevel"
            duration: 800
            from: mapView.zoomLevel
            to: mapView.zoomLevel + 1
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation {
            id: zoomOutAnimation
            target: mapView
            property: "zoomLevel"
            duration: 800
            from: mapView.zoomLevel
            to: mapView.zoomLevel - 1
        }

        PropertyAnimation {
            id: showMenuMapType
            target: menuMapType
            property: "width"
            duration: 400
            from: 0
            to: 180
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation {
            id: hideMenuMapType
            target: menuMapType
            property: "width"
            duration: 400
            from: menuMapType.width
            to: 0
            easing.type: Easing.InOutQuad
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

        // Keyboard for input address
        InputPanel {
            id: keyboardMap
            y: Qt.inputMethod.visible ? parent.height + 50 - keyboardMap.height
                                      : parent.height
            width: mapItem.width
        }
    }
}
