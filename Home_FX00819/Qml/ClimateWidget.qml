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
        id: mode

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
        height: 60
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Text {
            text: "Climate"
            color: "#FFFFFF"
            font.pixelSize: 36
            font.family: firaSans.name
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // Position title area: Driver, Passenger
    Item {
        id: positionTitle
        height: 70
        anchors {
            top: climateTitle.bottom
            left: parent.left
            right: parent.right
        }

        Item {
            id: driverTitle
            width: 240
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }

            Text {
                id: driverText
                text: "DRIVER"
                color: "#FFFFFF"
                font.pixelSize: 30
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

        Item {
            id: passengerTitle
            width: 240
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }

            Text {
                id: passengerText
                text: "PASSENGER"
                color: "#FFFFFF"
                font.pixelSize: 30
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

    // Highlight climate widget
    WidgetHighlight {
        id: climateHighlight
        anchors.fill: parent
        disablePressed: true
    }

    // Air control area: arrow mode for Driver and Passenger, fan level
    Item {
        id: airControl
        height: 120
        anchors {
            top: positionTitle.bottom
            left: parent.left
            right: parent.right
        }

        //        Rectangle {
        //            color: "LightBlue"
        //            anchors.fill: parent
        //        }

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
            property string path: "qrc:/Images/Climate/widget_climate_wind_level_"
                                  + climateModel.fan_level + ".png"
            source: path
            anchors.centerIn: parent
        }

        // Seat driver icon
        Image {
            id: seatDriver
            source: "qrc:/Images/Climate/widget_climate_arrow_seat.png"
            x: 91
            anchors.verticalCenter: parent.verticalCenter
        }

        // Seat passenger icon
        Image {
            id: seatPassenger
            source: "qrc:/Images/Climate/widget_climate_arrow_seat.png"
            x: 490
            anchors.verticalCenter: parent.verticalCenter
        }

        // Arrow on foot for Driver
        Image {
            id: footArrowDriver

            property string path: "qrc:/Images/Climate/widget_climate_arrow_foot_"
            property int currentArrowMode: climateModel.driver_wind_foot

            x: 35
            y: 40

            source: {
                if (currentArrowMode == mode.off)
                    return (path + "off.png")
                else if (currentArrowMode == mode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == mode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == mode.off)
                        climateModel.setDriverWindFoot(mode.cold)
                    else if (parent.currentArrowMode == mode.cold)
                        climateModel.setDriverWindFoot(mode.warm)
                    else if (parent.currentArrowMode == mode.warm)
                        climateModel.setDriverWindFoot(mode.off)
                }
            }
        }

        // Arrow on face for Driver
        Image {
            id: faceArrowDriver

            // Path common of arrow face
            property string path: "qrc:/Images/Climate/widget_climate_arrow_face_"

            // Hold the value mode wind on face of driver
            property int currentArrowMode: climateModel.driver_wind_face

            x: 75
            y: 25

            source: {
                if (currentArrowMode == mode.off)
                    return (path + "off.png")
                else if (currentArrowMode == mode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == mode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == mode.off)
                        climateModel.setDriverWindFace(mode.cold)
                    else if (parent.currentArrowMode == mode.cold)
                        climateModel.setDriverWindFace(mode.warm)
                    else if (parent.currentArrowMode == mode.warm)
                        climateModel.setDriverWindFace(mode.off)
                }
            }
        }

        // Arrow on foot for Passenger
        Image {
            id: footArrowPassenger

            property string path: "qrc:/Images/Climate/widget_climate_arrow_foot_"
            property int currentArrowMode: climateModel.passenger_wind_foot

            x: 433
            y: 40

            source: {
                if (currentArrowMode == mode.off)
                    return (path + "off.png")
                else if (currentArrowMode == mode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == mode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == mode.off)
                        climateModel.setPassengerWindFoot(mode.cold)
                    else if (parent.currentArrowMode == mode.cold)
                        climateModel.setPassengerWindFoot(mode.warm)
                    else if (parent.currentArrowMode == mode.warm)
                        climateModel.setPassengerWindFoot(mode.off)
                }
            }
        }

        // Arrow on face for Passenger
        Image {
            id: faceArrowPassenger

            property string path: "qrc:/Images/Climate/widget_climate_arrow_face_"
            property int currentArrowMode: climateModel.passenger_wind_face

            x: 473
            y: 25

            source: {
                if (currentArrowMode == mode.off)
                    return (path + "off.png")
                else if (currentArrowMode == mode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == mode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == mode.off)
                        climateModel.setPassengerWindFace(mode.cold)
                    else if (parent.currentArrowMode == mode.cold)
                        climateModel.setPassengerWindFace(mode.warm)
                    else if (parent.currentArrowMode == mode.warm)
                        climateModel.setPassengerWindFace(mode.off)
                }
            }
        }
    }

    // Temperature area
    Item {
        id: temperItem

        property string src_arrow: "qrc:/Images/Climate/arrow_"

        //        Rectangle {
        //            color: "YellowGreen"
        //            anchors.fill: parent
        //        }

        height: 120
        anchors {
            top: airControl.bottom
            left: parent.left
            right: parent.right
        }

        // Driver temperature area
        Item {
            id: driverTempItem
            width: 240
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }

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
                source: temperItem.src_arrow + "up_normal.png"
                anchors.bottom: driverTemp.top
                anchors.horizontalCenter: driverTemp.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (climateModel.driver_temp < climate.max_temperature) {
                            arrowAnimation.target = upArrowDriverTemp
                            arrowAnimation.to = temperItem.src_arrow + "up_pressed.png"
                            arrowAnimation.restart()
                            climateModel.setDriverTemp(climateModel.driver_temp + 1)
                        }
                    }

                    onReleased: {
                        arrowAnimation.target = upArrowDriverTemp
                        arrowAnimation.to = temperItem.src_arrow + "up_normal.png"
                        arrowAnimation.restart()
                    }
                }
            }

            Image {
                id: downArrowDriverTemp
                source: temperItem.src_arrow + "down_normal.png"
                anchors.top: driverTemp.bottom
                anchors.horizontalCenter: driverTemp.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (climateModel.driver_temp > climate.min_temperature) {
                            arrowAnimation.target = downArrowDriverTemp
                            arrowAnimation.to = temperItem.src_arrow + "down_pressed.png"
                            arrowAnimation.restart()
                            climateModel.setDriverTemp(climateModel.driver_temp - 1)
                        }
                    }

                    onReleased: {
                        arrowAnimation.target = downArrowDriverTemp
                        arrowAnimation.to = temperItem.src_arrow + "down_normal.png"
                        arrowAnimation.restart()
                    }
                }
            }
        }

        // Fan icon
        Image {
            id: fanIcon
            source: "qrc:/Images/Climate/widget_climate_ico_fan.png"
            anchors.centerIn: parent

            // Left arrow icon for decrease temperature
            Image {
                id: leftArrow
                source: temperItem.src_arrow + "left_normal.png"
                anchors.right: fanIcon.left
                anchors.rightMargin: 5
                anchors.verticalCenter: fanIcon.verticalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (climateModel.fan_level > climate.min_fan_level) {
                            arrowAnimation.target = leftArrow
                            arrowAnimation.to = temperItem.src_arrow + "left_pressed.png"
                            arrowAnimation.restart()
                            climateModel.setFanLevel(climateModel.fan_level - 1)
                        }
                    }

                    onReleased: {
                        arrowAnimation.target = leftArrow
                        arrowAnimation.to = temperItem.src_arrow + "left_normal.png"
                        arrowAnimation.restart()
                    }
                }
            }

            // Right arrow icon for increase temperature
            Image {
                id: rightArrow
                source: temperItem.src_arrow + "right_normal.png"
                anchors.left: fanIcon.right
                anchors.leftMargin: 5
                anchors.verticalCenter: fanIcon.verticalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (climateModel.fan_level < climate.max_fan_level) {
                            arrowAnimation.target = rightArrow
                            arrowAnimation.to = temperItem.src_arrow + "right_pressed.png"
                            arrowAnimation.restart()
                            climateModel.setFanLevel(climateModel.fan_level + 1)
                        }
                    }

                    onReleased: {
                        arrowAnimation.target = rightArrow
                        arrowAnimation.to = temperItem.src_arrow + "right_normal.png"
                        arrowAnimation.restart()
                    }
                }
            }
        }

        // Passenger temperature area
        Item {
            id: passengerTempItem
            width: 240
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
                source: temperItem.src_arrow + "up_normal.png"
                anchors.bottom: passengerTemp.top
                anchors.horizontalCenter: passengerTemp.horizontalCenter

                MouseArea {
                    anchors.fill: parent

                    onPressed: {
                        if (climateModel.passenger_temp < climate.max_temperature) {
                            arrowAnimation.target = upArrowPassengerTemp
                            arrowAnimation.to = temperItem.src_arrow + "up_pressed.png"
                            arrowAnimation.restart()
                            climateModel.setPassengerTemp(climateModel.passenger_temp + 1)
                        }
                    }

                    onReleased: {
                        arrowAnimation.target = upArrowPassengerTemp
                        arrowAnimation.to = temperItem.src_arrow + "up_normal.png"
                        arrowAnimation.restart()
                    }
                }
            }

            Image {
                id: downArrowPassengerTemp
                source: temperItem.src_arrow + "down_normal.png"
                anchors.top: passengerTemp.bottom
                anchors.horizontalCenter: passengerTemp.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        if (climateModel.passenger_temp > climate.min_temperature) {
                            arrowAnimation.target = downArrowPassengerTemp
                            arrowAnimation.to = temperItem.src_arrow + "down_pressed.png"
                            arrowAnimation.restart()
                            climateModel.setPassengerTemp(climateModel.passenger_temp - 1)
                        }
                    }
                    onReleased: {
                        arrowAnimation.target = downArrowPassengerTemp
                        arrowAnimation.to = temperItem.src_arrow + "down_normal.png"
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
        height: 80

        anchors {
            top: temperItem.bottom
            left: parent.left
            right: parent.right
        }

        Item {
            id: autoMode
            width: 240
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }

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
        
        Item {
            id: outsideTemperItem
            anchors {
                top: parent.top
                left: autoMode.right
                right: syncMode.left
                bottom: parent.bottom
            }

            Item {
                id: outsideTitle
                height: parent.height / 2
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Text {
                    text: "OUTSIDE"
                    color: "#FFFFFF"
                    font.pixelSize: 28
                    font.family: cantarell.name
                    anchors.centerIn: parent
                }
            }

            Item {
                id: outsideTemper
                anchors {
                    top: outsideTitle.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Text {
                    color: "#FFFFFF"
                    font.pixelSize: 38
                    font.family: ubuntu.name
                    text: (climateModel.outside_temp + "\xB0C")
                    anchors.centerIn: parent
                }
            }
        }

        Item {
            id: syncMode
            width: 240
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }

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

    Item {
        id: heatWindMode

        property string path: "qrc:/Images/Climate/"

        anchors {
            top: modeItem.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Row {

            spacing: 50
            anchors.centerIn: parent

            Image {
                id: driverHeatedSeat

                property int currentHeatedSeat: climateModel.driver_heated_seat

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentHeatedSeat == mode.off)
                        return (heatWindMode.path + "driver_seat_off.png")
                    else if (currentHeatedSeat == mode.cold)
                        return (heatWindMode.path + "driver_seat_cold.png")
                    else if (currentHeatedSeat == mode.warm)
                        return (heatWindMode.path + "driver_seat_warm.png")
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (parent.currentHeatedSeat == mode.off)
                            climateModel.setDriverHeatedSeat(mode.cold)
                        else if (parent.currentHeatedSeat == mode.cold)
                            climateModel.setDriverHeatedSeat(mode.warm)
                        else if (parent.currentHeatedSeat == mode.warm)
                            climateModel.setDriverHeatedSeat(mode.off)
                    }
                }
            }

            Image {
                id: headDefog

                property int currentHeadDefog: climateModel.head_defog

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentHeadDefog == mode.off)
                        return (heatWindMode.path + "head_defog_off.png")
                    else if (currentHeadDefog == mode.cold)
                        return (heatWindMode.path + "head_defog_cold.png")
                    else if (currentHeadDefog == mode.warm)
                        return (heatWindMode.path + "head_defog_warm.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentHeadDefog == mode.off)
                            climateModel.setHeadDefog(mode.cold)
                        else if (parent.currentHeadDefog == mode.cold)
                            climateModel.setHeadDefog(mode.warm)
                        else if (parent.currentHeadDefog == mode.warm)
                            climateModel.setHeadDefog(mode.off)
                    }
                }
            }

            Image {
                id: airInCar

                property int currentAirInCar: climateModel.air_in_car

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentAirInCar == mode.off)
                        return (heatWindMode.path + "air_car_off.png")
                    else if (currentAirInCar == mode.cold)
                        return (heatWindMode.path + "air_in_car.png")
                    else if (currentAirInCar == mode.warm)
                        return (heatWindMode.path + "air_out_car.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentAirInCar == mode.off)
                            climateModel.setAirInCar(mode.cold)
                        else if (parent.currentAirInCar == mode.cold)
                            climateModel.setAirInCar(mode.warm)
                        else if (parent.currentAirInCar == mode.warm)
                            climateModel.setAirInCar(mode.off)
                    }
                }
            }

            Image {
                id: rearDefog

                property int currentRearDefog: climateModel.rear_defog

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentRearDefog == mode.off)
                        return (heatWindMode.path + "rear_defog_off.png")
                    else if (currentRearDefog == mode.cold)
                        return (heatWindMode.path + "rear_defog_cold.png")
                    else if (currentRearDefog == mode.warm)
                        return (heatWindMode.path + "rear_defog_warm.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentRearDefog == mode.off)
                            climateModel.setRearDefog(mode.cold)
                        else if (parent.currentRearDefog == mode.cold)
                            climateModel.setRearDefog(mode.warm)
                        else if (parent.currentRearDefog == mode.warm)
                            climateModel.setRearDefog(mode.off)
                    }
                }
            }

            Image {
                id: passengerHeatedSeat

                property int currentHeatedSeat: climateModel.passenger_heated_seat

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentHeatedSeat == mode.off)
                        return (heatWindMode.path + "passenger_seat_off.png")
                    else if (currentHeatedSeat == mode.cold)
                        return (heatWindMode.path + "passenger_seat_cold.png")
                    else if (currentHeatedSeat == mode.warm)
                        return (heatWindMode.path + "passenger_seat_warm.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentHeatedSeat == mode.off)
                            climateModel.setPassengerHeatedSeat(mode.cold)
                        else if (parent.currentHeatedSeat == mode.cold)
                            climateModel.setPassengerHeatedSeat(mode.warm)
                        else if (parent.currentHeatedSeat == mode.warm)
                            climateModel.setPassengerHeatedSeat(mode.off)
                    }
                }
            }
        }
    }
}
