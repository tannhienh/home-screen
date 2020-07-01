import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13

// Guide Area
Item {
    id: guideItem

    // Guide background area
    Rectangle {
        id: guideBg
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "#502E2E2E" }
            GradientStop { position: 0.2; color: "#504A4A4A" }
            GradientStop { position: 1; color: "#502B2E30" }
        }

        // Hide virtual Keyboard
        MouseArea {
            anchors.fill: parent

            // Hide virtual Keyboard
            onClicked: {
                focus = true
            }
        }
    }

    //------------------------------------------------------------------------//
    // Begin Choose place location
    //------------------------------------------------------------------------//
    Item {
        id: inputPlaceItem
        height: 200
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Rectangle {
            id: inputPlaceBg
            color: "#6065EE"
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0; color: "#4A4A4A" }
                GradientStop { position: 1; color: "#2E2E2E" }
            }
        }

        // current location icon
        Image {
            id: startLocationIcon
            source: "qrc:/Apps/Map/images/start_location.png"
            anchors {
                top: parent.top
                topMargin: 40
                left: parent.left
                leftMargin: 20
            }
        }

        // Text input start location
        TextField {
            id: startAddress
            placeholderText: qsTr("Choose starting location")
            font.pixelSize: 30
            color: "#515356"
            height: 50
            selectByMouse: true
            selectedTextColor: color
            selectionColor: "#503498DB"

            anchors {
                left: parent.left
                leftMargin: 70
                right: parent.right
                rightMargin: 40
                verticalCenter: startLocationIcon.verticalCenter
            }

            background: Rectangle {
                color: "#FFFFFF"
                radius: 4
                border.width: startAddress.activeFocus ? 3 : 0
                border.color: startAddress.activeFocus ? "#5DADE2" : "#FFFFFF"
            }
        }

        // destination location icon
        Image {
            id: destinationIcon
            source: "qrc:/Apps/Map/images/destination_location.png"
            anchors {
                bottom: parent.bottom
                bottomMargin: 40
                horizontalCenter: startLocationIcon.horizontalCenter
            }
        }

        // Text input destination location
        TextField {
            id: destinationAddress
            placeholderText: qsTr("Choose destination")
            font.pixelSize: 30
            color: "#515356"
            height: 50
            selectByMouse: true
            selectedTextColor: color
            selectionColor: "#503498DB"

            anchors {
                left: parent.left
                leftMargin: 70
                right: parent.right
                rightMargin: 40
                verticalCenter: destinationIcon.verticalCenter
            }

            background: Rectangle {
                color: "#FFFFFF"
                radius: 4
                border.width: destinationAddress.activeFocus ? 3 : 0
                border.color: destinationAddress.activeFocus ? "#5DADE2" : "#FFFFFF"
            }
        }

        Column {
            id: dotColumn
            width: 5
            spacing: 10
            anchors {
                top: startLocationIcon.bottom
                topMargin: dotColumn.width
                bottom: destinationIcon.top
                bottomMargin: dotColumn.width
                horizontalCenter: startLocationIcon.horizontalCenter
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

        // Shadow for placeHolder icon
        DropShadow {
            anchors.fill: destinationIcon
            source: destinationIcon
            color: "#aa000000"
            radius: 10
            samples: 21
            verticalOffset: 2
        }

        // Arrow reverse location and destination
        Image {
            id: arrowReverse

            property string src: "qrc:/Apps/Map/images/arrow_"

            source: src + "normal.png"
            anchors {
                right: parent.right
                rightMargin: 5
                verticalCenter: parent.verticalCenter
            }

            MouseArea {
                property string temp: ""
                anchors.fill: parent
                onPressed:{
                    parent.source = parent.src + "press.png"
                    temp = startAddress.text
                    startAddress.text = destinationAddress.text
                    destinationAddress.text = temp
                }
                onReleased: parent.source = parent.src + "normal.png"
            }
        }
    }
    //------------------------------------------------------------------------//
    // End Choose place location
    //------------------------------------------------------------------------//

    // Shadown for guide area on right edge
    DropShadow {
        anchors.fill: guideBg
        source: guideBg
        color: "#aa000000"
        radius: 30
        samples: 61
    }

    DropShadow {
        anchors.fill: inputPlaceItem
        source: inputPlaceItem
        color: "#aa000000"
        radius: 30
        samples: 61
    }

    // Locations near here
    Item {
        id: locationsNearHereItem
        state: mapSettings.showExploreLocations ? "showExploreLocations"
                                            : "hideExploreLocations"
        anchors {
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
        }

        Rectangle {
            id: locationsNearHereBg
            anchors.fill: locationsNearHereItem
            border.width: 1
            border.color: "#797979"
            radius: 5
            gradient: Gradient {
                GradientStop { position: 0; color: "#4A4A4A" }
                GradientStop { position: 1; color: "#2E2E2E" }
            }
        }

        Text {
            id: locationsNearHereTitle
            text: qsTr("Explore locations near here")
            color: "#FFFFFF"
            font.pixelSize: 24
            font.bold: true
            anchors {
                top: parent.top
                topMargin: 10
                left: parent.left
                leftMargin: 10
            }
        }

        // Arrow for show/hide Explore locations near here item
        Image {
            id: arrowIcon
            property bool status: mapSettings.showExploreLocations
            property string down_arrow: "qrc:/Apps/Map/images/down_arrow.png"
            property string up_arrow: "qrc:/Apps/Map/images/up_arrow.png"

            source: status == true ? down_arrow : up_arrow
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 20
            }

            MouseArea {
                anchors.fill: arrowIcon
                onPressed: parent.opacity = 0.6
                onReleased: parent.opacity = 1.0
                onClicked: {
                    if (arrowIcon.status) {
                        mapSettings.showExploreLocations = false
                        arrowIcon.status = false
                    }
                    else {
                        mapSettings.showExploreLocations = true
                        arrowIcon.status = true
                    }
                }
            }
        }

        // Swipe view explore location near here
        SwipeView {
            id: swipeExplore
            currentIndex: 1
            clip: true
            spacing: 20
            anchors {
                top: locationsNearHereTitle.bottom
                left: locationsNearHereItem.left
                right: locationsNearHereItem.right
                bottom: locationsNearHereItem.bottom
                topMargin: 5
                bottomMargin: 20
            }

            // First page of swipe explore location near here
            Item {
                id: page0
                width: swipeExplore.width
                height: swipeExplore.height

                Row {
                    spacing: (locationsNearHereItem.width - 100 * 3) / 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    ExploreItem {
                        colorItem: "#ABB2B9"
                        src: "qrc:/Apps/Map/images/holtel.png"
                        title: "Holtels"
                    }

                    ExploreItem {
                        colorItem: "#A3E4D7"
                        src: "qrc:/Apps/Map/images/supermarket.png"
                        title: "Supermarkets"
                    }

                    ExploreItem {
                        colorItem: "#D2B4DE"
                        src: "qrc:/Apps/Map/images/hospital.png"
                        title: "Hopitals"
                    }
                }
            }

            // Second page of swipe explore location near here
            Item {
                id: page1
                width: swipeExplore.width
                height: swipeExplore.height

                Row {
                    spacing: (locationsNearHereItem.width - 100 * 3) / 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    ExploreItem {
                        colorItem: "#FAD7A0"
                        src: "qrc:/Apps/Map/images/restaurant.png"
                        title: "Restaurants"
                    }

                    ExploreItem {
                        colorItem: "#AED6F1"
                        src: "qrc:/Apps/Map/images/parking.png"
                        title: "Parking Lots"
                    }

                    ExploreItem {
                        colorItem: "#ABEBC6"
                        src: "qrc:/Apps/Map/images/gas_station.png"
                        title: "Gas Station"
                    }
                }
            }

            // Third page of swipe explore location near here
            Item {
                id: page2
                width: swipeExplore.width
                height: swipeExplore.height

                Row {
                    spacing: (locationsNearHereItem.width - 100 * 3) / 4
                    anchors.horizontalCenter: parent.horizontalCenter

                    ExploreItem {
                        colorItem: "#EDBB99"
                        src: "qrc:/Apps/Map/images/coffee.png"
                        title: "Coffee"
                    }

                    ExploreItem {
                        colorItem: "#F5B7B1"
                        src: "qrc:/Apps/Map/images/bar.png"
                        title: "Bars"
                    }

                    ExploreItem {
                        colorItem: "#F0B27A"
                        src: "qrc:/Apps/Map/images/bank.png"
                        title: "Banks"
                    }
                }
            }
        }

        // Page indicator for swipe view explore near here
        PageIndicator {
            id: indicatorExplore
            count: swipeExplore.count
            currentIndex: swipeExplore.currentIndex
            anchors.bottom: locationsNearHereItem.bottom
            anchors.horizontalCenter: swipeExplore.horizontalCenter

            delegate: Rectangle {
                implicitWidth: 10
                implicitHeight: 10
                radius: width
                color: "#b7b7b7"
                opacity: index === swipeExplore.currentIndex ? 1.0 : 0.5

            }
        }

        states: [
            State {
                name: "hideExploreLocations"
                PropertyChanges {
                    target: locationsNearHereItem
                    height: locationsNearHereTitle.height + 20
                }
                PropertyChanges {
                    target: swipeExplore
                    opacity: 0
                }
                PropertyChanges {
                    target: indicatorExplore
                    opacity: 0
                }
            },

            State {
                name: "showExploreLocations"
                PropertyChanges {
                    target: locationsNearHereItem
                    height: guideItem.height * 0.2
                }
                PropertyChanges {
                    target: swipeExplore
                    opacity: 1
                }
                PropertyChanges {
                    target: indicatorExplore
                    opacity: 1
                }
            }
        ]

        transitions: Transition {
            from: "hideExploreLocations"
            to: "showExploreLocations"
            reversible: true

            PropertyAnimation {
                target: locationsNearHereItem
                property: "height"
                duration: 400
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                targets: [swipeExplore, indicatorExplore]
                property: "opacity"
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    }

    DropShadow {
        anchors.fill: locationsNearHereItem
        source: locationsNearHereItem
        color: "#aa000000"
        radius: 30
        samples: 61
    }

    Text {
        id: textDefault
        text: qsTr("Where will you go today?")
        color: "#8A8A8A"
        font.pixelSize: 30
        anchors.centerIn: guideItem
    }
}
