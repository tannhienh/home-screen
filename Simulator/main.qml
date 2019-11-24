import QtQuick 2.13
import QtQuick.Controls 2.13

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 450
    height: 600
    title: qsTr("Simulator - Home Screen")

    function saveData() {
        climate.set_data(driverWindFace.currentIndex,
                         driverWindFoot.currentIndex,
                         driverTemper.realValue,
                         fanLevel.value,
                         passengerWindFace.currentIndex,
                         passengerWindFoot.currentIndex,
                         passengerTemper.realValue,
                         autoMode.position,
                         syncMode.position,
                         outsideValueText.outsideTemp)
    }

    ListModel {
        id: windModeModel
        ListElement { key: "Off"; value: 0 }
        ListElement { key: "Cold"; value: 1 }
        ListElement { key: "Warm"; value: 2 }
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
        model: windModeModel
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: saveData()
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
        model: windModeModel
        anchors {
            top: driverWindFace.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: saveData()
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: driverTemperText
        text: "Temperature driver"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: driverTemper.verticalCenter
        }
    }

    SpinBox {
        id: driverTemper
        from: 165
        to: 310
        stepSize: 5
        anchors {
            top: driverWindFoot.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        property int decimals: 1
        property real realValue: value / 10

        validator: DoubleValidator {
            bottom: Math.min(driverTemper.from, driverTemper.to)
            top:  Math.max(driverTemper.from, driverTemper.to)
        }

        textFromValue: function(value, locale) {
            return Number(value / 10).toLocaleString(locale, 'f',
                                                     driverTemper.decimals)
        }

        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
        }

        onRealValueChanged: saveData()
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: fanText
        text: "Fan: "
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
        value: 0
        anchors {
            top: driverTemper.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }

        onValueChanged: saveData()
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
        model: windModeModel
        anchors {
            top: fanLevel.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: saveData()
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
        model: windModeModel
        anchors {
            top: passengerWindFace.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        onCurrentIndexChanged: saveData()
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: passengerTemperText
        text: "Temperature driver"
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: passengerTemper.verticalCenter
        }
    }

    SpinBox {
        id: passengerTemper
        from: 165
        to: 310
        stepSize: 5
        anchors {
            top: passengerWindFoot.bottom
            topMargin: 10
            left: parent.left
            leftMargin: parent.width / 2
        }

        property int decimals: 1
        property real realValue: value / 10

        validator: DoubleValidator {
            bottom: Math.min(passengerTemper.from, passengerTemper.to)
            top:  Math.max(passengerTemper.from, passengerTemper.to)
        }

        textFromValue: function(value, locale) {
            return Number(value / 10).toLocaleString(locale, 'f',
                                                     passengerTemper.decimals)
        }

        valueFromText: function(text, locale) {
            return Number.fromLocaleString(locale, text)
        }

        onRealValueChanged: saveData()
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
        text: position == 1.0 ? "ON" : "OFF"

        onPositionChanged: {saveData()
            console.log("autoMode: " + autoMode.position)
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
        text: position == 1.0 ? "ON" : "OFF"

        onPositionChanged: {saveData()
            console.log("syncMode: " + syncMode.position)
        }
    }
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    Text {
        id: outsideText
        text: "OUTSIDE Temp (Random): "
        anchors {
            left: parent.left
            leftMargin: 20
            verticalCenter: outsideValueText.verticalCenter
        }
    }

    Text {
        id: outsideValueText

        property double outsideTemp: (Math.random() * 50).toFixed(1)

        text: outsideTemp

        anchors {
            top: syncMode.bottom
            topMargin: 20
            left: parent.left
            leftMargin: parent.width / 2
        }

        onTextChanged: saveData()
    }
    //------------------------------------------------------------------------//
}
