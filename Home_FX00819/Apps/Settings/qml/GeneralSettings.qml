import QtQuick 2.13
import QtQuick.Controls 1.6
import QtQuick.Controls 2.13

ScrollView {
    id: scrollView

    property int heightItemSetting: 53

    clip: true

    // Hide settings dropdown when clicked on background
    MouseArea {
        anchors.fill: parent
        onClicked: focus = true
    }

    Column {
        id: generalSettings
        spacing: 20
        anchors.fill: parent
        anchors{
            topMargin: 30
            leftMargin: 50
            rightMargin: 50
            bottomMargin: 50
        }

        // Title Date and Time settings group
        Item {
            id: dateTimeTitleItem
            width: scrollView.width
            height: childrenRect.height

            Text {
                id: dateTimeSettingsLabel
                text: qsTr("Date and time")
                color: "#FFFFFF"
                font.pixelSize: 42
                font.family: cantarell.name
            }

            Rectangle {
                id: lineBottomDateTimeLabel
                width: parent.width * 0.5 - 50
                height: 3
                anchors.top: dateTimeSettingsLabel.bottom

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0; color: "#a4a4a4" }
                    GradientStop { position: 1; color: "#4a4a4a" }
                }
            }
        }

        // Time zone settings
        Item {
            id: timeZoneItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: timeZoneLabel
                text: qsTr("Time Zone")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                width: 250
                height: parent.height
                font.pixelSize: 36
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle { color: "#FFFFFF" }

                indicator: Canvas {
                    width: 20
                    height: 10
                    contextType: "2d"
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#434444";
                        context.fill();
                    }
                }
            }
        }

        // Time setting
        Item {
            id: timeItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: timeLabel
                text: qsTr("Time")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            TextField {
                property var locale: Qt.locale()
                property string currentTime: new Date()
                property var hourFormat: fullTimeFormat.checked ? "HH" : "hh"
                property string timeFormatString: hourFormat + ":mm"

                width: 250
                height: parent.height
                font.pixelSize: 36
                font.family: ubuntu.name
                inputMethodHints: Qt.ImhPreferNumbers
                text: Qt.formatTime(currentTime, timeFormatString);
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        // Time format setting
        Item {
            id: timeFormatItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: timeFormatLabel
                text: qsTr("Time format")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            RadioButton {
                id: shortTimeFormat
                text: "12h"
                font.family: ubuntu.name
                font.pixelSize: 36
                checked: false
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }

                indicator: Rectangle {
                    id: indicator12h
                    implicitWidth: 40
                    implicitHeight: 40
                    radius: 20
                    border.color: shortTimeFormat.down ? "#42d2df" : "#7deef8"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: 30
                        height: 30
                        radius: 15
                        color: shortTimeFormat.down ? "#42d2df" : "#7deef8"
                        visible: shortTimeFormat.checked
                        anchors.centerIn: parent
                    }
                }

                contentItem: Text {
                    text: shortTimeFormat.text
                    font: shortTimeFormat.font
                    opacity: enabled ? 1.0 : 0.5
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    anchors {
                        left: indicator12h.right
                        leftMargin: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            shortTimeFormat.focus = true
                            if (shortTimeFormat.checked == false )
                                       shortTimeFormat.checked = true
                        }
                    }
                }
            }

            RadioButton {
                id: fullTimeFormat
                text: "24h"
                font.family: ubuntu.name
                font.pixelSize: 36
                checked: true
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.7
                    verticalCenter: parent.verticalCenter
                }

                indicator: Rectangle {
                    id: indicator24h
                    implicitWidth: 40
                    implicitHeight: 40
                    radius: 20
                    border.color: fullTimeFormat.down ? "#42d2df" : "#7deef8"
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        width: 30
                        height: 30
                        radius: 15
                        color: fullTimeFormat.down ? "#42d2df" : "#7deef8"
                        visible: fullTimeFormat.checked
                        anchors.centerIn: parent
                    }
                }

                contentItem: Text {
                    text: fullTimeFormat.text
                    font: fullTimeFormat.font
                    opacity: enabled ? 1.0 : 0.5
                    color: "#FFFFFF"
                    verticalAlignment: Text.AlignVCenter
                    anchors {
                        left: indicator24h.right
                        leftMargin: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            fullTimeFormat.focus = true
                            if (fullTimeFormat.checked == false )
                                       fullTimeFormat.checked = true
                        }
                    }
                }
            }
        }

        // Date setting
        Item {
            id: dateItem
            width: parent.width
            height: heightItemSetting
            z: 1

            Text {
                id: dateLabel
                text: qsTr("Date")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                id: comboBoxDate
                property string dateFormatString: dateFormat.displayText
                width: 250
                height: parent.height
                font.pixelSize: 36
                font.family: ubuntu.name
                displayText: Qt.formatDate(calendar.selectedDate, dateFormatString)
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle { color: "#FFFFFF" }

                indicator: Canvas {
                    width: 20
                    height: 10
                    contextType: "2d"
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#434444";
                        context.fill();
                    }
                }

                onFocusChanged: if (focus) {
                                    calendar.visible = true
                                } else {
                                    calendar.visible = false
                                }
            }

            Calendar {
                id: calendar
                width: 450
                height: 450
                visible: false
                anchors {
                    left: comboBoxDate.left
                    top: comboBoxDate.bottom
                }
            }
        }

        // Date format setting
        Item {
            id: dateFormatItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: dateFormatLabel
                text: qsTr("Date format")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                id: dateFormat
                width: 250
                height: parent.height
                font.pixelSize: 36
                font.family: ubuntu.name
                currentIndex: 2
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }
                model: [
                    "MMM. dd",
                    "MMM dd, yyyy",
                    "dd.MM.yyyy"
                ]

                background: Rectangle { color: "#FFFFFF" }

                delegate: ItemDelegate {
                    width: dateFormat.width
                    contentItem: Text {
                        text: Qt.formatDate(calendar.selectedDate, modelData)
                        color: "#434444"
                        font: dateFormat.font
                        verticalAlignment: Text.AlignVCenter
                    }
                    highlighted: dateFormat.highlightedIndex === index
                }

                indicator: Canvas {
                    width: 20
                    height: 10
                    contextType: "2d"
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#434444";
                        context.fill();
                    }
                }

                contentItem: Text {
                    text: dateFormat.displayText
                    font: dateFormat.font
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }

        // Other settings group
        Item {
            id: otherSettingsTitleItem
            width: parent.width
            height: 83

            Text {
                id: otherSettingsLabel
                text: qsTr("Other settings")
                color: "#FFFFFF"
                font.pixelSize: 42
                font.family: cantarell.name
                anchors.bottom: lineBottomOtherLabel.top
            }

            Rectangle {
                id: lineBottomOtherLabel
                width: parent.width * 0.5
                height: 3
                anchors.bottom: parent.bottom

                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0; color: "#a4a4a4" }
                    GradientStop { position: 1; color: "#4a4a4a" }
                }
            }
        }


        // Temp unit
        Item {
            id: tempUnit
            width: parent.width
            height: heightItemSetting

            Text {
                id: tempUnitLabel
                text: qsTr("Temp Unit")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: cUnitLabel
                text: "\xB0C"
                font.pixelSize: 36
                font.family: cantarell.name
                color: "#FFFFFF"
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }
            }

            // unit Switch
            Switch {
                id: unitSwitch
                anchors {
                    left: cUnitLabel.right
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }

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
                font.pixelSize: 36
                font.family: cantarell.name
                color: "#FFFFFF"
                anchors {
                    left: unitSwitch.right
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        Item {
            id: soundItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: soundLabel
                text: qsTr("Sound")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                width: 250
                height: parent.height
                font.pixelSize: 36
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle { color: "#FFFFFF" }

                indicator: Canvas {
                    width: 20
                    height: 10
                    contextType: "2d"
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#434444";
                        context.fill();
                    }
                }
            }
        }

        Item {
            id: rearSeatEndtertainmentItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: rearSeatEntertainmentLabel
                text: qsTr("Rear-seat entertainment")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                width: 250
                height: parent.height
                font.pixelSize: 36
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle { color: "#FFFFFF" }

                indicator: Canvas {
                    width: 20
                    height: 10
                    contextType: "2d"
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#434444";
                        context.fill();
                    }
                }
            }
        }

        Item {
            id: popupsItem
            width: parent.width
            height: heightItemSetting

            Text {
                id: popupsLabel
                text: qsTr("Popups")
                color: "#FFFFFF"
                font.pixelSize: 40
                font.family: cantarell.name
                anchors.verticalCenter: parent.verticalCenter
            }

            ComboBox {
                width: 250
                height: parent.height
                font.pixelSize: 36
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.5
                    verticalCenter: parent.verticalCenter
                }

                background: Rectangle { color: "#FFFFFF" }

                indicator: Canvas {
                    width: 20
                    height: 10
                    contextType: "2d"
                    anchors {
                        right: parent.right
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    onPaint: {
                        context.reset();
                        context.moveTo(0, 0);
                        context.lineTo(width, 0);
                        context.lineTo(width / 2, height);
                        context.closePath();
                        context.fillStyle = "#434444";
                        context.fill();
                    }
                }
            }
        }
    }
}
