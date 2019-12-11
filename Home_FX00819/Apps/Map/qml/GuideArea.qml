import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13

// Guide Area
Item {
    id: guideItem

    // Guide background area
    Rectangle {
        id: guideBg
        color: "#FFFFFF"
        anchors.fill: parent
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
        }

        // current location icon
        Image {
            id: startLocationButton
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
            font.pixelSize: 20
            color: "#515356"
            height: 50
            anchors {
                left: startLocationButton.right
                leftMargin: 20
                right: parent.right
                rightMargin: 40
                verticalCenter: startLocationButton.verticalCenter
            }

            background: Rectangle {
                color: "#FFFFFF"
                radius: 4
            }
        }

        // destination location icon
        Image {
            id: destinationButton
            source: "qrc:/Apps/Map/images/destination_location.png"
            anchors {
                bottom: parent.bottom
                bottomMargin: 40
                horizontalCenter: startLocationButton.horizontalCenter
            }
        }

        // Text input destination location
        TextField {
            id: destinationAddress
            placeholderText: qsTr("Choose destination")
            font.pixelSize: 20
            color: "#515356"
            height: 50
            anchors {
                left: destinationButton.right
                leftMargin: 20
                right: parent.right
                rightMargin: 40
                verticalCenter: destinationButton.verticalCenter
            }

            background: Rectangle {
                color: "#FFFFFF"
                radius: 4
            }
        }

        Column {
            id: dotColumn
            width: 5
            spacing: 10 // height / 5
            anchors {
                top: startLocationButton.bottom
                topMargin: dotColumn.width
                bottom: destinationButton.top
                bottomMargin: dotColumn.width
                horizontalCenter: startLocationButton.horizontalCenter
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
            anchors.fill: destinationButton
            source: destinationButton
            color: "#aa000000"
            radius: 10
            samples: 21
            verticalOffset: 2
        }

        // Arrow reverse location and destination
        Image {
            id: arrowReverse

            property string src: "qrc:/Apps/Map/images/arrow"

            source: src + "_1.png"
            anchors {
                right: parent.right
                rightMargin: 5
                verticalCenter: parent.verticalCenter
            }

            MouseArea {
                property string temp: ""
                anchors.fill: parent
                onPressed:{
                    parent.source = parent.src + "_2.png"
                    temp = startAddress.text
                    startAddress.text = destinationAddress.text
                    destinationAddress.text = temp
                }
                onReleased: parent.source = parent.src + "_1.png"
            }
        }
    }
    //------------------------------------------------------------------------//
    // End Choode place location
    //------------------------------------------------------------------------//

    // Shadown for guide area on right edge
    DropShadow {
        anchors.fill: guideBg
        source: guideBg
        color: "#aa000000"
        radius: 20
        samples: 31
    }

    DropShadow {
        anchors.fill: inputPlaceItem
        source: inputPlaceItem
        color: "#aa000000"
        radius: 20
        samples: 31
    }

    // Locations near here
    Item {
        id: nearHereItem
        height: 200
        anchors {
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
            bottom: parent.bottom
            bottomMargin: 10
        }

        Rectangle {
            id: nearHereBg
            color: "#FFFFFF"
            anchors.fill: nearHereItem
            border.width: 1
            border.color: "#d3d3d3"
            radius: 5
        }

        Text {
            id: titleText
            text: qsTr("Explore near here")
            color: "#515356"
            font.pixelSize: 20
            font.bold: true
            anchors {
                top: parent.top
                topMargin: 10
                left: parent.left
                leftMargin: 10
            }
        }

        Image {
            id: arrowImage
            property bool status: true
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
                anchors.fill: arrowImage
                onPressed: parent.opacity = 0.6
                onReleased: parent.opacity = 1.0
                onClicked: {
                    if (arrowImage.status) {
                        arrowImage.status = false

                        // Hide explore
                        nearHereHide.restart()
                        swipeExploreHide.targets = [swipeExplore, indicatorExplore]
                        swipeExploreHide.restart()
                    }
                    else {
                        arrowImage.status = true

                        // Show explore
                        nearHereShow.restart()
                        swipeExploreShow.targets = [swipeExplore, indicatorExplore]
                        swipeExploreShow.restart()
                    }
                }
            }
        }

        // List view explore near here
        SwipeView {
            id: swipeExplore
            currentIndex: 1
            clip: true
            spacing: 20
            anchors {
                top: titleText.bottom
                left: nearHereItem.left
                right: nearHereItem.right
                bottom: nearHereItem.bottom
                topMargin: 10
                leftMargin: 20
                rightMargin: 20
                bottomMargin: 20
            }

            // First page of swipe explore
            Item {
                id: page0
                width: swipeExplore.width
                height: swipeExplore.height

                Row {
                    spacing: 20
                    anchors.fill: parent

                    ExploreItem {
                        color: "#ABB2B9"
                        src: "qrc:/Apps/Map/images/holtel.png"
                        title: "Holtels"
                    }

                    ExploreItem {
                        color: "#A3E4D7"
                        src: "qrc:/Apps/Map/images/supermarket.png"
                        title: "Supermarkets"
                    }

                    ExploreItem {
                        color: "#D2B4DE"
                        src: "qrc:/Apps/Map/images/hospital.png"
                        title: "Hopitals"
                    }
                }
            }

            // Second page of swipe explore
            Item {
                id: page1
                width: swipeExplore.width
                height: swipeExplore.height

                Row {
                    spacing: 20
                    anchors.fill: parent

                    ExploreItem {
                        color: "#FAD7A0"
                        src: "qrc:/Apps/Map/images/restaurant.png"
                        title: "Restaurants"
                    }

                    ExploreItem {
                        color: "#AED6F1"
                        src: "qrc:/Apps/Map/images/parking.png"
                        title: "Parking Lots"
                    }

                    ExploreItem {
                        color: "#ABEBC6"
                        src: "qrc:/Apps/Map/images/gas_station.png"
                        title: "Gas Station"
                    }
                }
            }

            // Third page of swipe explore
            Item {
                id: page2
                width: swipeExplore.width
                height: swipeExplore.height

                Row {
                    spacing: 20
                    anchors.fill: parent

                    ExploreItem {
                        color: "#EDBB99"
                        src: "qrc:/Apps/Map/images/coffee.png"
                        title: "Coffee"
                    }

                    ExploreItem {
                        color: "#F5B7B1"
                        src: "qrc:/Apps/Map/images/bar.png"
                        title: "Bars"
                    }

                    ExploreItem {
                        color: "#F0B27A"
                        src: "qrc:/Apps/Map/images/bank.png"
                        title: "Banks"
                    }
                }
            }

            PropertyAnimation {
                id: nearHereHide
                target: nearHereItem
                property: "height"
                from: nearHereItem.height
                to: titleText.height + 20
                duration: 500
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                id: nearHereShow
                target: nearHereItem
                property: "height"
                from: titleText.height + 20
                to: guideItem.height * 0.2
                duration: 500
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                id: swipeExploreHide
                property: "opacity"
                from: 1
                to: 0
                duration: 500
                easing.type: Easing.InOutQuad
            }

            PropertyAnimation {
                id: swipeExploreShow
                property: "opacity"
                from: 0
                to: 1
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }

        PageIndicator {
            id: indicatorExplore
            count: swipeExplore.count
            currentIndex: swipeExplore.currentIndex
            anchors.top: swipeExplore.bottom
            anchors.horizontalCenter: swipeExplore.horizontalCenter
        }
    }

    Text {
        id: textDefault
        text: qsTr("Where will you go today?")
        color: "#8A8A8A"
        font.pixelSize: 20
        anchors.centerIn: guideItem
    }
}
