import QtQuick 2.13

FocusScope {
    id: climate

    property alias stateHighLight: climateHighlight.state

    // Minimum teperature
    readonly property int min_temperature: 16

    // Maximum teperature
    readonly property int max_temperature: 32

    // Minimum fan level
    readonly property int min_fan_level: 0

    // Maximum fan level
    readonly property int max_fan_level: 10

    // Enumeration arrow mode for climate
    QtObject {
        id: arrowMode

        property int off: 0
        property int cold: 1
        property int warm: 2
    }

    // Background color for climate widget area
    Rectangle {
        id: climateBg
        color: "#1B1B1B"
        opacity: 0.5
        anchors.fill: parent
    }

    // Title climate widget
    Item {
        id: climateTitle
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 110

        Text {
            text: "Climate"
            color: "#FFFFFF"
            font.pixelSize: 36
            font.family: firaSans.name
            anchors.centerIn: parent
        }
    }

    // Position title: Driver and Passenger
    Item {
        id: position
        anchors.top: climateTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 66

        // Driver title
        Item {
            id: driverTextItem
            width: 215
            height: parent.height
            anchors.left: parent.left

            Text {
                id: driverText
                text: "DRIVER"
                color: "#FFFFFF"
                font.pixelSize: 32
                font.family: ubuntu.name
                anchors.centerIn: parent
            }

            // Line under Driver title
            Image {
                id: lineDriver
                source: "qrc:/Images/Climate/widget_climate_line.png"
                width: driverText.width
                anchors.top: driverText.bottom
                anchors.horizontalCenter: driverText.horizontalCenter
            }
        }

        // Passenger title
        Item {
            id: passengerTextItem
            width: 215
            height: parent.height
            anchors.right: parent.right

            Text {
                id: passengerText
                text: "PASSENGER"
                color: "#FFFFFF"
                font.pixelSize: 32
                font.family: ubuntu.name
                anchors.centerIn: parent
            }

            // Line under Passenger title
            Image {
                id: linePassenger
                source: "qrc:/Images/Climate/widget_climate_line.png"
                width: passengerText.width
                anchors.top: passengerText.bottom
                anchors.horizontalCenter: passengerText.horizontalCenter
            }
        }
    }

    // Background wind level = 0
    Image {
        id: windBg
        source: "qrc:/Images/Climate/widget_climate_wind_level_0.png"
        anchors.centerIn: parent
    }

    // Image win level corresponding fan level
    Image {
        id: fanLevel

        // Hold path fan image corresponding level
        property var path: "qrc:/Images/Climate/widget_climate_wind_level_"
                           + climateModel.fan_level + ".png"
        source: path
        anchors.centerIn: parent
    }

    // Seat driver icon
    Image {
        id: seatDriver
        source: "qrc:/Images/Climate/widget_climate_arrow_seat.png"
        x: 91
        y: 215
    }

    // Seat passenger icon
    Image {
        id: seatPassenger
        source: "qrc:/Images/Climate/widget_climate_arrow_seat.png"
        x: 490
        y: 215
    }

    // Highlight climate widget
    WidgetHighlight {
        id: climateHighlight
        anchors.fill: parent
        disablePressed: true
    }

    // Arrow on foot for Driver
    Image {
        id: footArrowDriver

        property var path: "qrc:/Images/Climate/widget_climate_arrow_foot_"
        property int currentArrowMode: climateModel.driver_wind_foot

        x: 35
        y: 250
        source: {
            if (currentArrowMode == arrowMode.off)
                return (path + "off.png")
            else if (currentArrowMode == arrowMode.cold)
                return (path + "cold.png")
            else if (currentArrowMode == arrowMode.warm)
                return (path + "warm.png")
        }

        MouseArea {
            anchors.fill: footArrowDriver
            onClicked: {
                if (footArrowDriver.currentArrowMode == arrowMode.off)
                    climateModel.setDriverWindFoot(arrowMode.cold)
                else if (footArrowDriver.currentArrowMode == arrowMode.cold)
                    climateModel.setDriverWindFoot(arrowMode.warm)
                else if (footArrowDriver.currentArrowMode == arrowMode.warm)
                    climateModel.setDriverWindFoot(arrowMode.off)
            }
        }
    }

    // Arrow on face for Driver
    Image {
        id: faceArrowDriver

        // Path common of arrow face
        property var path: "qrc:/Images/Climate/widget_climate_arrow_face_"

        // Hold the value mode wind on face of driver
        property int currentArrowMode: climateModel.driver_wind_face

        x: 75
        y: 230
        source: {
            if (currentArrowMode == arrowMode.off)
                return (path + "off.png")
            else if (currentArrowMode == arrowMode.cold)
                return (path + "cold.png")
            else if (currentArrowMode == arrowMode.warm)
                return (path + "warm.png")
        }

        // Change arrow mode when choose arrow icon
        // follow order: off, cold, warm
        MouseArea {
            anchors.fill: faceArrowDriver
            onClicked: {
                if (faceArrowDriver.currentArrowMode == arrowMode.off)
                    climateModel.setDriverWindFace(arrowMode.cold)
                else if (faceArrowDriver.currentArrowMode == arrowMode.cold)
                    climateModel.setDriverWindFace(arrowMode.warm)
                else if (faceArrowDriver.currentArrowMode == arrowMode.warm)
                    climateModel.setDriverWindFace(arrowMode.off)
            }
        }
    }

    // Arrow on foot for Passenger
    Image {
        id: footArrowPassenger

        property var path: "qrc:/Images/Climate/widget_climate_arrow_foot_"
        property int currentArrowMode: climateModel.passenger_wind_foot

        x: 433
        y: 250
        source: {
            if (climateModel.passenger_wind_foot == 0)
                return (path + "off.png")
            else if (climateModel.passenger_wind_foot == 1)
                return (path + "cold.png")
            else if (climateModel.passenger_wind_foot == 2)
                return (path + "warm.png")
        }

        MouseArea {
            anchors.fill: footArrowPassenger
            onClicked: {
                if (footArrowPassenger.currentArrowMode == arrowMode.off)
                    climateModel.setPassengerWindFoot(arrowMode.cold)
                else if (footArrowPassenger.currentArrowMode == arrowMode.cold)
                    climateModel.setPassengerWindFoot(arrowMode.warm)
                else if (footArrowPassenger.currentArrowMode == arrowMode.warm)
                    climateModel.setPassengerWindFoot(arrowMode.off)
            }
        }
    }

    // Arrow on face for Passenger
    Image {
        id: faceArrowPassenger

        property var path: "qrc:/Images/Climate/widget_climate_arrow_face_"
        property int currentArrowMode: climateModel.passenger_wind_face

        x: 473
        y: 230
        source: {
            if (climateModel.passenger_wind_face == 0)
                return (path + "off.png")
            else if (climateModel.passenger_wind_face == 1)
                return (path + "cold.png")
            else if (climateModel.passenger_wind_face == 2)
                return (path + "warm.png")
        }

        MouseArea {
            anchors.fill: faceArrowPassenger
            onClicked: {
                if (faceArrowPassenger.currentArrowMode == arrowMode.off)
                    climateModel.setPassengerWindFace(arrowMode.cold)
                else if (faceArrowPassenger.currentArrowMode == arrowMode.cold)
                    climateModel.setPassengerWindFace(arrowMode.warm)
                else if (faceArrowPassenger.currentArrowMode == arrowMode.warm)
                    climateModel.setPassengerWindFace(arrowMode.off)
            }
        }
    }

    //
    Item {
        id: temperItem

        property string src_arrow: "qrc:/Images/Climate/ico_arrow_"

        anchors {
            left: parent.left
            right: parent.right
            top: fanLevel.bottom
            bottom: modeItem.top
        }

        Item {
            width: 215
            height: parent.height
            anchors.left: parent.left

            Text {
                id: driverTemp
                color: "#FFFFFF"
                font.pixelSize: 55
                font.family: ubuntu.name
                anchors.centerIn: parent
                verticalAlignment: Text.AlignVCenter
                height: driverTemp.contentHeight
                text: {
                    if (climateModel.driver_temp == climate.min_temperature)
                        return "LOW"
                    else if (climateModel.driver_temp == climate.max_temperature)
                        return "HIGH"
                    else
                        return (climateModel.driver_temp + "\xB0C")
                }
            }

            Image {
                id: upArrowDriverTemp
                source: temperItem.src_arrow + "up_small.png"
                anchors.bottom: driverTemp.top
                anchors.horizontalCenter: driverTemp.horizontalCenter

                MouseArea {
                    anchors.fill: upArrowDriverTemp
                    onPressed: {
                        if (climateModel.driver_temp < climate.max_temperature) {
                            arrowAnimation.target = upArrowDriverTemp
                            arrowAnimation.to = temperItem.src_arrow + "up_big.png"
                            arrowAnimation.restart()
                            climateModel.setDriverTemp(climateModel.driver_temp + 1)
                        }
                    }
                    onReleased: {
                        arrowAnimation.target = upArrowDriverTemp
                        arrowAnimation.to = temperItem.src_arrow + "up_small.png"
                        arrowAnimation.restart()
                    }
                }
            }

            Image {
                id: downArrowDriverTemp
                source: temperItem.src_arrow + "down_small.png"
                anchors.top: driverTemp.bottom
                anchors.horizontalCenter: driverTemp.horizontalCenter

                MouseArea {
                    anchors.fill: downArrowDriverTemp
                    onPressed: {
                        if (climateModel.driver_temp > climate.min_temperature) {
                            arrowAnimation.target = downArrowDriverTemp
                            arrowAnimation.to = temperItem.src_arrow + "down_big.png"
                            arrowAnimation.restart()
                            climateModel.setDriverTemp(climateModel.driver_temp - 1)
                        }
                    }
                    onReleased: {
                        arrowAnimation.target = downArrowDriverTemp
                        arrowAnimation.to = temperItem.src_arrow + "down_small.png"
                        arrowAnimation.restart()
                    }
                }
            }
        }

        // Fan icon
        Image {
            id: fanIcon
            source: "qrc:/Images/Climate/widget_climate_ico_fan.png"
            anchors.centerIn: temperItem

            // Left arrow icon for decrease temperature
            Image {
                id: leftArrow
                source: temperItem.src_arrow + "left_small.png"
                anchors.right: fanIcon.left
                anchors.rightMargin: 5
                anchors.verticalCenter: fanIcon.verticalCenter

                MouseArea {
                    anchors.fill: leftArrow

                    onPressed: {
                        if (climateModel.fan_level > climate.min_fan_level) {
                            arrowAnimation.target = leftArrow
                            arrowAnimation.to = temperItem.src_arrow + "left_big.png"
                            arrowAnimation.restart()
                            climateModel.setFanLevel(climateModel.fan_level - 1)
                        }
                    }

                    onReleased: {
                        arrowAnimation.target = leftArrow
                        arrowAnimation.to = temperItem.src_arrow + "left_small.png"
                        arrowAnimation.restart()
                    }
                }
            }

            // Right arrow icon for increase temperature
            Image {
                id: rightArrow
                source: temperItem.src_arrow + "right_small.png"
                anchors.left: fanIcon.right
                anchors.leftMargin: 5
                anchors.verticalCenter: fanIcon.verticalCenter

                MouseArea {
                    anchors.fill: rightArrow
                    onPressed: {
                        if (climateModel.fan_level < climate.max_fan_level) {
                            arrowAnimation.target = rightArrow
                            arrowAnimation.to = temperItem.src_arrow + "right_big.png"
                            arrowAnimation.restart()
                            climateModel.setFanLevel(climateModel.fan_level + 1)
                        }
                    }
                    onReleased: {
                        arrowAnimation.target = rightArrow
                        arrowAnimation.to = temperItem.src_arrow + "right_small.png"
                        arrowAnimation.restart()
                    }
                }
            }
        }

        Item {
            width: 215
            height: parent.height
            anchors.right: parent.right

            Text {
                id: passengerTemp
                color: "#FFFFFF"
                font.pixelSize: 55
                font.family: ubuntu.name
                anchors.centerIn: parent
                text: {
                    if (climateModel.passenger_temp == 16)
                        return "LOW"
                    else if (climateModel.passenger_temp == 32)
                        return "HIGH"
                    else
                        return (climateModel.passenger_temp + "\xB0C")
                }
            }

            Image {
                id: upArrowPassengerTemp
                source: temperItem.src_arrow + "up_small.png"
                anchors.bottom: passengerTemp.top
                anchors.horizontalCenter: passengerTemp.horizontalCenter

                MouseArea {
                    anchors.fill: upArrowPassengerTemp
                    onPressed: {
                        if (climateModel.passenger_temp < climate.max_temperature) {
                            arrowAnimation.target = upArrowPassengerTemp
                            arrowAnimation.to = temperItem.src_arrow + "up_big.png"
                            arrowAnimation.restart()
                            climateModel.setPassengerTemp(climateModel.passenger_temp + 1)
                        }
                    }
                    onReleased: {
                        arrowAnimation.target = upArrowPassengerTemp
                        arrowAnimation.to = temperItem.src_arrow + "up_small.png"
                        arrowAnimation.restart()
                    }
                }
            }

            Image {
                id: downArrowPassengerTemp
                source: temperItem.src_arrow + "down_small.png"
                anchors.top: passengerTemp.bottom
                anchors.horizontalCenter: passengerTemp.horizontalCenter

                MouseArea {
                    anchors.fill: downArrowPassengerTemp
                    onPressed: {
                        if (climateModel.passenger_temp > climate.min_temperature) {
                            arrowAnimation.target = downArrowPassengerTemp
                            arrowAnimation.to = temperItem.src_arrow + "down_big.png"
                            arrowAnimation.restart()
                            climateModel.setPassengerTemp(climateModel.passenger_temp - 1)
                        }
                    }
                    onReleased: {
                        arrowAnimation.target = downArrowPassengerTemp
                        arrowAnimation.to = temperItem.src_arrow + "down_small.png"
                        arrowAnimation.restart()
                    }
                }
            }
        }

        // Animation for increase and decrease arrow when pressed and released
        PropertyAnimation  {
            id: arrowAnimation
            property: "source"
            duration: 0
        }
    }

    // Climate mode: Auto, Sync
    Item {
        id: modeItem
        height: 120 // 148
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Item {
            width: 215
            height: parent.height
            anchors.left: parent.left

            Text {
                text: "AUTO"
                color: climateModel.auto_mode ? "#FFFFFF" : "#7A7A7A"
                font.pixelSize: 48
                font.family: cantarell.name
                anchors.centerIn: parent

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (climateModel.auto_mode)
                            climateModel.setAutoMode(false)
                        else
                            climateModel.setAutoMode(true)
                    }
                }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 5

            Text {
                text: "OUTSIDE"
                color: "#FFFFFF"
                font.pixelSize: 28
                font.family: cantarell.name
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                color: "#FFFFFF"
                font.pixelSize: 38
                font.family: ubuntu.name
                anchors.horizontalCenter: parent.horizontalCenter
                text: (climateModel.outside_temp + "\xB0C")
            }
        }

        Item {
            width: 215
            height: parent.height
            anchors.right: parent.right

            Text {
                text: "SYNC"
                color: climateModel.sync_mode ? "#FFFFFF" : "#7A7A7A"
                font.pixelSize: 48
                font.family: cantarell.name
                anchors.centerIn: parent

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (climateModel.sync_mode)
                            climateModel.setSyncMode(false)
                        else
                            climateModel.setSyncMode(true)
                    }
                }
            }
        }
    }
}
