import QtQuick 2.13
import QtPositioning 5.13

FocusScope {
    id: climate

    property alias stateHighLight: climateHighlight.state

    // Minimum teperature
    readonly property int min_temperature: mainSettings.tempUnit == "C" ? 16 : 61

    // Maximum teperature
    readonly property int max_temperature: mainSettings.tempUnit == "C" ? 32 : 90

    // Minimum fan level
    readonly property int min_fan_level: 0

    // Maximum fan level
    readonly property int max_fan_level: 10

    // Enumeration climate mode
    QtObject {
        id: climateMode

        property int off: 0
        property int cold: 1
        property int warm: 2
    }

    // Enumeration air quality mode
    QtObject {
        id: airQualityMode

        property int automatic: 0
        property int recirculation: 1
        property int fresh: 2
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
            source: "qrc:/Images/Climate/widget_climate_driver_icon.png"
            x: 50
            anchors.verticalCenter: parent.verticalCenter
        }

        // Seat passenger icon
        Image {
            id: seatPassenger
            source: "qrc:/Images/Climate/widget_climate_passenger_icon.png"
            x: 481
            anchors.verticalCenter: parent.verticalCenter
        }

        // Arrow on face for Driver
        Image {
            id: faceArrowDriver

            // Path common of arrow face
            property string path: "qrc:/Images/Climate/climate_arrow_driver_face_"

            // Hold the value mode wind on face of driver
            property int currentArrowMode: climateModel.driver_wind_face

            x: 89
            y: 25

            source: {
                if (currentArrowMode == climateMode.off)
                    return (path + "off.png")
                else if (currentArrowMode == climateMode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == climateMode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == climateMode.off)
                        climateModel.setDriverWindFace(climateMode.cold)
                    else if (parent.currentArrowMode == climateMode.cold)
                        climateModel.setDriverWindFace(climateMode.warm)
                    else if (parent.currentArrowMode == climateMode.warm)
                        climateModel.setDriverWindFace(climateMode.off)
                }
            }
        }

        // Arrow on foot for Driver
        Image {
            id: footArrowDriver

            property string path: "qrc:/Images/Climate/climate_arrow_driver_foot_"
            property int currentArrowMode: climateModel.driver_wind_foot

            x: 145
            y: 45

            source: {
                if (currentArrowMode == climateMode.off)
                    return (path + "off.png")
                else if (currentArrowMode == climateMode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == climateMode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == climateMode.off)
                        climateModel.setDriverWindFoot(climateMode.cold)
                    else if (parent.currentArrowMode == climateMode.cold)
                        climateModel.setDriverWindFoot(climateMode.warm)
                    else if (parent.currentArrowMode == climateMode.warm)
                        climateModel.setDriverWindFoot(climateMode.off)
                }
            }
        }

        // Arrow on face for Passenger
        Image {
            id: faceArrowPassenger

            property string path: "qrc:/Images/Climate/climate_arrow_passenger_face_"
            property int currentArrowMode: climateModel.passenger_wind_face

            x: 468
            y: 25

            source: {
                if (currentArrowMode == climateMode.off)
                    return (path + "off.png")
                else if (currentArrowMode == climateMode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == climateMode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == climateMode.off)
                        climateModel.setPassengerWindFace(climateMode.cold)
                    else if (parent.currentArrowMode == climateMode.cold)
                        climateModel.setPassengerWindFace(climateMode.warm)
                    else if (parent.currentArrowMode == climateMode.warm)
                        climateModel.setPassengerWindFace(climateMode.off)
                }
            }
        }

        // Arrow on foot for Passenger
        Image {
            id: footArrowPassenger

            property string path: "qrc:/Images/Climate/climate_arrow_passenger_foot_"
            property int currentArrowMode: climateModel.passenger_wind_foot

            x: 426
            y: 45

            source: {
                if (currentArrowMode == climateMode.off)
                    return (path + "off.png")
                else if (currentArrowMode == climateMode.cold)
                    return (path + "cold.png")
                else if (currentArrowMode == climateMode.warm)
                    return (path + "warm.png")
            }

            // Change arrow mode when choose arrow icon
            // In order: off, cold, warm
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (parent.currentArrowMode == climateMode.off)
                        climateModel.setPassengerWindFoot(climateMode.cold)
                    else if (parent.currentArrowMode == climateMode.cold)
                        climateModel.setPassengerWindFoot(climateMode.warm)
                    else if (parent.currentArrowMode == climateMode.warm)
                        climateModel.setPassengerWindFoot(climateMode.off)
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
                property int temp
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
                    else if (mainSettings.tempUnit == "C")
                        return (climateModel.driver_temp + "\xB0C")
                    else if (mainSettings.tempUnit == "F") {
                        return (climateModel.driver_temp + "\xB0F")
                    }
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
                    if (climateModel.passenger_temp == climate.min_temperature)
                        return "LOW"
                    else if (climateModel.passenger_temp == climate.max_temperature)
                        return "HIGH"
                    else if (mainSettings.tempUnit == "C")
                        return (climateModel.passenger_temp + "\xB0C")
                    else if (mainSettings.tempUnit == "F") {
                        return (climateModel.passenger_temp + "\xB0F")
                    }
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

        property bool checkTempRespone: false

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
                    text: modeItem.checkTempRespone ? (mainSettings.outsideTemp
                            + "\xB0" + mainSettings.tempUnit) : "--"
                            + "\xB0" + mainSettings.tempUnit
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

            spacing: 35
            anchors.centerIn: parent

            Image {
                id: driverHeatedSeat

                property int currentHeatedSeat: climateModel.driver_heated_seat

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentHeatedSeat == climateMode.off)
                        return (heatWindMode.path + "heat_seat_driver_off.png")
                    else if (currentHeatedSeat == climateMode.cold)
                        return (heatWindMode.path + "heat_seat_driver_cold.png")
                    else if (currentHeatedSeat == climateMode.warm)
                        return (heatWindMode.path + "heat_seat_driver_warm.png")
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (parent.currentHeatedSeat == climateMode.off)
                            climateModel.setDriverHeatedSeat(climateMode.cold)
                        else if (parent.currentHeatedSeat == climateMode.cold)
                            climateModel.setDriverHeatedSeat(climateMode.warm)
                        else if (parent.currentHeatedSeat == climateMode.warm)
                            climateModel.setDriverHeatedSeat(climateMode.off)
                    }
                }
            }

            Image {
                id: headDefog

                property int currentHeadDefog: climateModel.head_defog

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentHeadDefog == climateMode.off)
                        return (heatWindMode.path + "head_defog_off.png")
                    else if (currentHeadDefog == climateMode.cold)
                        return (heatWindMode.path + "head_defog_cold.png")
                    else if (currentHeadDefog == climateMode.warm)
                        return (heatWindMode.path + "head_defog_warm.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentHeadDefog == climateMode.off)
                            climateModel.setHeadDefog(climateMode.cold)
                        else if (parent.currentHeadDefog == climateMode.cold)
                            climateModel.setHeadDefog(climateMode.warm)
                        else if (parent.currentHeadDefog == climateMode.warm)
                            climateModel.setHeadDefog(climateMode.off)
                    }
                }
            }

            // AC mode
            Text {
                id: acModeText
                property bool acMode: true
                text: "A/C"
                color: climateModel.ac_mode ? "#FFFFFF" : "#7A7A7A"
                font.pixelSize: 48
                font.family: cantarell.name
                verticalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (climateModel.ac_mode)
                            climateModel.setACMode(false)
                        else
                            climateModel.setACMode(true)
                    }
                }
            }

            Image {
                id: airQuality

                property int currentAirQuality: climateModel.air_quality

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentAirQuality == airQualityMode.automatic)
                        return (heatWindMode.path + "air_quality_auto.png")
                    else if (currentAirQuality == airQualityMode.recirculation)
                        return (heatWindMode.path + "air_quality_recirculation.png")
                    else if (currentAirQuality == airQualityMode.fresh)
                        return (heatWindMode.path + "air_quality_fresh.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentAirQuality == airQualityMode.automatic)
                            climateModel.setAirQuality(airQualityMode.recirculation)
                        else if (parent.currentAirQuality == airQualityMode.recirculation)
                            climateModel.setAirQuality(airQualityMode.fresh)
                        else if (parent.currentAirQuality == airQualityMode.fresh)
                            climateModel.setAirQuality(airQualityMode.automatic)
                    }
                }
            }

            Image {
                id: rearDefog

                property int currentRearDefog: climateModel.rear_defog

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentRearDefog == climateMode.off)
                        return (heatWindMode.path + "rear_defog_off.png")
                    else if (currentRearDefog == climateMode.cold)
                        return (heatWindMode.path + "rear_defog_cold.png")
                    else if (currentRearDefog == climateMode.warm)
                        return (heatWindMode.path + "rear_defog_warm.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentRearDefog == climateMode.off)
                            climateModel.setRearDefog(climateMode.cold)
                        else if (parent.currentRearDefog == climateMode.cold)
                            climateModel.setRearDefog(climateMode.warm)
                        else if (parent.currentRearDefog == climateMode.warm)
                            climateModel.setRearDefog(climateMode.off)
                    }
                }
            }

            Image {
                id: passengerHeatedSeat

                property int currentHeatedSeat: climateModel.passenger_heated_seat

                anchors.verticalCenter: parent.verticalCenter

                source: {
                    if (currentHeatedSeat == climateMode.off)
                        return (heatWindMode.path + "heat_seat_passenger_off.png")
                    else if (currentHeatedSeat == climateMode.cold)
                        return (heatWindMode.path + "heat_seat_passenger_cold.png")
                    else if (currentHeatedSeat == climateMode.warm)
                        return (heatWindMode.path + "heat_seat_passenger_warm.png")
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        if (parent.currentHeatedSeat == climateMode.off)
                            climateModel.setPassengerHeatedSeat(climateMode.cold)
                        else if (parent.currentHeatedSeat == climateMode.cold)
                            climateModel.setPassengerHeatedSeat(climateMode.warm)
                        else if (parent.currentHeatedSeat == climateMode.warm)
                            climateModel.setPassengerHeatedSeat(climateMode.off)
                    }
                }
            }
        }
    }

    // Get current coordinate latitude and longitude
    PositionSource {
        id: positionSource
        property double latitude: position.coordinate.latitude
        property double longitude: position.coordinate.longitude
    }

    // Timer for call API get current temperature with latitude and longitude
    // call interval is each 90 seconds
    Timer {
        interval: 90000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: weather.get(positionSource.latitude, positionSource.longitude);
    }

    // Handle signal when temperature changed then set again currentTemp
    Connections {
        target: weather
        onTempChanged: {
            if (!modeItem.checkTempRespone)
                modeItem.checkTempRespone = true

            if (mainSettings.tempUnit == "C")
                mainSettings.outsideTemp = weather.temp - 273.15
            else if (mainSettings.tempUnit == "F")
                mainSettings.outsideTemp = (weather.temp - 273.15) * 1.8 + 32
        }
    }

    // Set temperature unit for simulator when start app
    Component.onCompleted: {
        var tempUnit = mainSettings.tempUnit === "F" ? true : false
        climateModel.setTempUnit(tempUnit)
    }
}
