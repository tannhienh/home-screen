import QtQuick 2.13

Item {
    id: climate

    Rectangle {
        id: climateBg
        color: "#1B1B1B"
        opacity: 0.5
        anchors.fill: parent
    }

    Item {
        id: climateTitle
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.2

        Text {
            text: "Climate"
            color: "White"
            font.pixelSize: 36
            font.family: firaSans.name
            anchors.centerIn: parent
        }
    }

    Item {
        id: position
        anchors.top: climateTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.12

        Item {
            id: driverTextItem
            width: parent.width * 0.35
            height: parent.height
            anchors.left: parent.left

            Text {
                id: driverText
                text: "DRIVER"
                color: "White"
                font.pixelSize: 32
                font.family: ubuntu.name
                anchors.centerIn: parent
            }

            Image {
                id: lineDriver
                source: "qrc:/Images/Climate/widget_climate_line.png"
                width: driverText.width
                anchors.top: driverText.bottom
                anchors.horizontalCenter: driverText.horizontalCenter
            }
        }

        Item {
            id: passengerTextItem
            width: parent.width * 0.35
            height: parent.height
            anchors.right: parent.right

            Text {
                id: passengerText
                text: "PASSENGER"
                color: "White"
                font.pixelSize: 32
                font.family: ubuntu.name
                anchors.centerIn: parent
            }

            Image {
                id: linePassenger
                source: "qrc:/Images/Climate/widget_climate_line.png"
                width: passengerText.width
                anchors.top: passengerText.bottom
                anchors.horizontalCenter: passengerText.horizontalCenter
            }
        }
    }


    Image {
        id: windBg
        source: "qrc:/Images/Climate/widget_climate_wind_level_0.png"
        anchors.centerIn: parent
    }

    Image {
        id: fanLevel

        // Hold path fan image corresponding level
        property var path: "qrc:/Images/Climate/widget_climate_wind_level_"
                           + climateModel.fan_level + ".png"
        source: path
        anchors.centerIn: parent
    }

    Image {
        id: seatDriver
        source: "qrc:/Images/Climate/widget_climate_arrow_seat.png"
        x: 91
        y: 215
    }

    Image {
        id: faceArrowDriver

        property var path: "qrc:/Images/Climate/widget_climate_arrow_face_"

        x: 60
        y: 238
        source: {
            if (climateModel.driver_wind_face == 0)
                    return (path + "off.png")
                else if (climateModel.driver_wind_face == 1)
                    return (path + "cold.png")
                else if (climateModel.driver_wind_face == 2)
                    return (path + "warm.png")
        }
    }

    Image {
        id: footArrowDriver

        property var path: "qrc:/Images/Climate/widget_climate_arrow_foot_"

        x: 35
        y: 250
        source: {
            if (climateModel.driver_wind_foot == 0)
                    return (path + "off.png")
                else if (climateModel.driver_wind_foot == 1)
                    return (path + "cold.png")
                else if (climateModel.driver_wind_foot == 2)
                    return (path + "warm.png")
        }
    }

    Image {
        id: seatPassenger
        source: "qrc:/Images/Climate/widget_climate_arrow_seat.png"
        x: 490
        y: 215
    }

    Image {
        id: faceArrowPassenger

        property var path: "qrc:/Images/Climate/widget_climate_arrow_face_"

        x: 458
        y: 238
        source: {
            if (climateModel.passenger_wind_face == 0)
                    return (path + "off.png")
                else if (climateModel.passenger_wind_face == 1)
                    return (path + "cold.png")
                else if (climateModel.passenger_wind_face == 2)
                    return (path + "warm.png")
        }
    }

    Image {
        id: footArrowPassenger

        property var path: "qrc:/Images/Climate/widget_climate_arrow_foot_"

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
    }

    Item {
        id: temperItem
        anchors.top: windBg.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height * 0.14

        Item {
            width: parent.width * 0.35
            height: parent.height
            anchors.left: parent.left

            Text {
                id: driverTemp
                color: "White"
                font.pixelSize: 55
                font.family: ubuntu.name
                anchors.centerIn: parent
                text: {
                    if (climateModel.driver_temp == 16.5)
                          return "LOW"
                      else if (climateModel.driver_temp == 31.5)
                          return "HIGH"
                      else
                          return (climateModel.driver_temp + "\xB0C")
                }
            }
        }

        Item {
            width: parent.width * 0.3
            height: parent.height
            anchors.centerIn: parent

            Image {
                source: "qrc:/Images/Climate/widget_climate_ico_fan.png"
                anchors.centerIn: parent
            }
        }

        Item {
            width: parent.width * 0.35
            height: parent.height
            anchors.right: parent.right

            Text {
                id: passengerTemp
                color: "White"
                font.pixelSize: 55
                font.family: ubuntu.name
                anchors.centerIn: parent
                text: {
                    if (climateModel.passenger_temp == 16.5)
                          return "LOW"
                      else if (climateModel.passenger_temp == 31.5)
                          return "HIGH"
                      else
                          return (climateModel.passenger_temp + "\xB0C")
                }
            }
        }
    }

    Item {
        id: modeItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.24

        Item {
            width: parent.width * 0.35
            height: parent.height
            anchors.left: parent.left

            Text {
                text: "AUTO"
                color: climateModel.auto_mode === true ? "White" : "Gray"
                font.pixelSize: 48
                font.family: cantarell.name
                anchors.centerIn: parent
            }
        }

        Item {
            width: parent.width * 0.3
            height: parent.height
            anchors.centerIn: parent

            Column {
                anchors.centerIn: parent
                spacing: 4

                Text {
                    text: "OUTSIDE"
                    color: "White"
                    font.pixelSize: 28
                    font.family: cantarell.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: climateModel.outside_temp + "\xB0C"
                    color: "White"
                    font.pixelSize: 38
                    font.family: ubuntu.name
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        Item {
            width: parent.width * 0.35
            height: parent.height
            anchors.right: parent.right

            Text {
                text: "SYNC"
                color: climateModel.sync_mode === true ? "White" : "Gray"
                font.pixelSize: 48
                font.family: cantarell.name
                anchors.centerIn: parent
            }
        }
    }
}
