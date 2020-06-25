import QtQuick 2.13
import QtQuick.Controls 2.13

Item {

    // Background Settings detail
    Rectangle {
        id: settingsDetail
        opacity: 0.5
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: "#2B2E30" }
            GradientStop { position: 0.5; color: "#121213" }
            GradientStop { position: 1; color: "#2B2E30" }
        }

        // Hide virtual Keyboard
        MouseArea {
            anchors.fill: parent
            onClicked: {
                focus = true
            }
        }
    }

    Item {
        id: tempUnit
        anchors.centerIn: parent

        Text {
            text: "\xB0C"
            font.pixelSize: 20
            color: "#FFFFFF"
            anchors {
                verticalCenter: unitSwitch.verticalCenter
                right: unitSwitch.left
                rightMargin: 10
            }
        }

        Switch {
            id: unitSwitch
            anchors.centerIn: parent
            checked: mainSettings.tempUnit === "F" ? true : false
            onPositionChanged: {
                if (position) {
                    mainSettings.tempUnit = "F"
                    mainSettings.outsideTemp = (weather.temp - 273.15) * 1.8 + 32
                    climateModel.setTempUnit(true)
                }
                else {
                    mainSettings.tempUnit = "C"
                    mainSettings.outsideTemp = weather.temp - 273.15
                    climateModel.setTempUnit(false)
                }
            }
        }

        Text {
            text: "\xB0F"
            font.pixelSize: 20
            color: "#FFFFFF"
            anchors {
                verticalCenter: unitSwitch.verticalCenter
                left: unitSwitch.right
                leftMargin: 10
            }
        }
    }
}
