import QtQuick 2.13
import QtQuick.Controls 2.13

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 450
    height: 800
    title: qsTr("Simulator - Home Screen")

    ListModel {
        id: modeModel
        ListElement { key: "Off"; value: 0 }
        ListElement { key: "Cold"; value: 1 }
        ListElement { key: "Warm"; value: 2 }
    }

    ListModel {
        id: airCarModel
        ListElement { key: "Off"; value: 0 }
        ListElement { key: "In"; value: 1 }
        ListElement { key: "Out"; value: 2 }
    }

    ListModel {
        id: autoSyncModeModel
        ListElement { key: "ON"; value: 0 }
        ListElement { key: "OFF"; value: 1 }
    }

    //------------------------------------------------------------------------//
    Text {
        id: driverFaceText
        text: "Driver Wind On Face"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: driverWindFace.verticalCenter
        }
    }

    ComboBox {
        id: driverWindFace
        textRole: "key"
        currentIndex: climate.get_driver_wind_face()
        model: modeModel
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_driver_wind_face(driverWindFace.currentIndex)
            console.log("Driver Wind On Face: " + driverWindFace.currentIndex)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: driverFootText
        text: "Driver Wind On Foot"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: driverWindFoot.verticalCenter
        }
    }

    ComboBox {
        id: driverWindFoot
        textRole: "key"
        currentIndex: climate.get_driver_wind_foot()
        model: modeModel
        anchors {
            top: driverWindFace.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_driver_wind_foot(driverWindFoot.currentIndex)
            console.log("Driver Wind On Foot: " + driverWindFoot.currentIndex)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: driverTemperText
        text: "Temperature Driver"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: driverTemper.verticalCenter
        }
    }

    SpinBox {
        id: driverTemper
        from: 16
        to: 32
        stepSize: 1
        value: climate.get_driver_temp()
        anchors {
            top: driverWindFoot.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onValueChanged: {
            climate.set_driver_temp(driverTemper.value)
            console.log("Temperature driver: " + driverTemper.value)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: fanText
        text: "Fan Level: "
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: fanLevel.verticalCenter
        }
    }

    Text {
        id: fanValueText
        text: fanLevel.value
        anchors {
            left: fanText.right
            leftMargin: 20
            verticalCenter: fanLevel.verticalCenter
        }
    }

    Slider {
        id: fanLevel
        from: 0
        to: 10
        stepSize: 1
        value: climate.get_fan_level()
        anchors {
            top: driverTemper.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }

        onValueChanged: {
            climate.set_fan_level(fanLevel.value)
            console.log("Fan Level: " + fanLevel.value)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: passengerFaceText
        text: "Passenger Wind On Face"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: passengerWindFace.verticalCenter
        }
    }

    ComboBox {
        id: passengerWindFace
        textRole: "key"
        currentIndex: climate.get_passenger_wind_face()
        model: modeModel
        anchors {
            top: fanLevel.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_passenger_wind_face(passengerWindFace.currentIndex)
            console.log("Passenger Wind On Face: " + passengerWindFace.currentIndex)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: passengerFootText
        text: "Passenger Wind On Foot"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: passengerWindFoot.verticalCenter
        }
    }

    ComboBox {
        id: passengerWindFoot
        textRole: "key"
        currentIndex: climate.get_passenger_wind_foot()
        model: modeModel
        anchors {
            top: passengerWindFace.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_passenger_wind_foot(passengerWindFoot.currentIndex)
            console.log("Passenger Wind On Foot: " + passengerWindFoot.currentIndex)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: passengerTemperText
        text: "Temperature Passenger"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: passengerTemper.verticalCenter
        }
    }

    SpinBox {
        id: passengerTemper
        from: 16
        to: 32
        stepSize: 1
        value: climate.get_passenger_temp()
        anchors {
            top: passengerWindFoot.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onValueChanged: {
            climate.set_passenger_temp(passengerTemper.value)
            console.log("Temperature Passenger: " + passengerTemper.value)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: autoModeText
        text: "Auto Mode"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: autoMode.verticalCenter
        }
    }

    Switch {
        id: autoMode
        anchors {
            top: passengerTemper.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }
        checked: climate.get_auto_mode()
        text: checked ? "ON" : "OFF"

        onCheckedChanged: {
            climate.set_auto_mode(autoMode.checked)

            console.log("Auto Mode: " + autoMode.checked)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: syncModeText
        text: "Sync Mode"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: syncMode.verticalCenter
        }
    }

    Switch {
        id: syncMode
        anchors {
            top: autoMode.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }
        checked: climate.get_sync_mode()
        text: checked ? "ON" : "OFF"

        onPositionChanged: {
            climate.set_sync_mode(syncMode.checked)

            console.log("Sync Mode: " + syncMode.checked)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: outsideText
        text: "Outside Temp: "
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: outsideTemper.verticalCenter
        }
    }

    SpinBox {
        id: outsideTemper
        from: -50
        to: 80
        stepSize: 1
        value: climate.get_outside_temp()
        anchors {
            top: syncMode.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }

        onValueChanged: {
            climate.set_outside_temp(outsideTemper.value)
            console.log("Outside Temp: " + outsideTemper.value)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: driverHeatedSeatText
        text: "Driver Heated Seat"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: driverHeatedSeat.verticalCenter
        }
    }

    ComboBox {
        id: driverHeatedSeat
        textRole: "key"
        currentIndex: climate.get_driver_heated_seat()
        model: modeModel
        anchors {
            top: outsideTemper.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_driver_heated_seat(driverHeatedSeat.currentIndex)
            console.log("Driver heated seat: " + driverHeatedSeat.currentIndex)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: headDefogText
        text: "Head Defog"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: headDefog.verticalCenter
        }
    }

    ComboBox {
        id: headDefog
        textRole: "key"
        currentIndex: climate.get_head_defog()
        model: modeModel
        anchors {
            top: driverHeatedSeat.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_head_defog(headDefog.currentIndex)
            console.log("Head Defog: " + headDefog.currentIndex)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: airInCarText
        text: "Air in Car"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: airInCar.verticalCenter
        }
    }

    ComboBox {
        id: airInCar
        textRole: "key"
        currentIndex: climate.get_air_in_car()
        model: airCarModel
        anchors {
            top: headDefog.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_air_in_car(airInCar.currentIndex)
            console.log("Air in Car: " + airInCar.currentIndex)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: rearDefogText
        text: "Rear Defog"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: rearDefog.verticalCenter
        }
    }

    ComboBox {
        id: rearDefog
        textRole: "key"
        currentIndex: climate.get_rear_defog()
        model: modeModel
        anchors {
            top: airInCar.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_rear_defog(rearDefog.currentIndex)
            console.log("Rear defog: " + rearDefog.currentIndex)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: passengerHeatedSeatText
        text: "Passenger Heated Seat"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: passengerHeatedSeat.verticalCenter
        }
    }

    ComboBox {
        id: passengerHeatedSeat
        textRole: "key"
        currentIndex: climate.get_passenger_heated_seat()
        model: modeModel
        anchors {
            top: rearDefog.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: {
            climate.set_passenger_heated_seat(passengerHeatedSeat.currentIndex)
            console.log("Passenger Heated Seat: " + passengerHeatedSeat.currentIndex)
        }
    }

    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//

    Connections {
        target: climate
        onDataChanged: {
            driverWindFace.currentIndex = climate.get_driver_wind_face()
            driverWindFoot.currentIndex = climate.get_driver_wind_foot()
            driverTemper.value = climate.get_driver_temp()
            fanLevel.value = climate.get_fan_level()
            passengerWindFace.currentIndex = climate.get_passenger_wind_face()
            passengerWindFoot.currentIndex = climate.get_passenger_wind_foot()
            passengerTemper.value = climate.get_passenger_temp()
            autoMode.checked = climate.get_auto_mode()
            syncMode.checked = climate.get_sync_mode()
            outsideTemper.value = climate.get_outside_temp()
            driverHeatedSeat.currentIndex = climate.get_driver_heated_seat()
            headDefog.currentIndex = climate.get_head_defog()
            airInCar.currentIndex = climate.get_air_in_car()
            rearDefog.currentIndex = climate.get_rear_defog()
            passengerHeatedSeat.currentIndex = climate.get_passenger_heated_seat()
        }
    }
}
