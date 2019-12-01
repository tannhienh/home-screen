import QtQuick 2.13
import QtQuick.Controls 2.13
import "Common" // Button

// Status Bar
// width: 1920
// height: 85

Item {
    id: statusBarItem

    property bool isShowBackButton: false
    property alias visibleEditButton: editButton.visible
    signal backButtonClicked

    height: 85
    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    // Background status bar
    Rectangle {
        id: statusBarBg
        anchors.fill: parent
        color: "#000000" // Black color
        opacity: 0.3
    }

    // Edit button
    Button {
        id: editButton
        property bool statusDone: false
        icon_src: "qrc:/Images/StatusBar/btn_done"
        visible: false
        anchors {
            left: parent.left
            leftMargin: 22
            verticalCenter: parent.verticalCenter
        }

        onClicked: {
            if (statusDone) {
                console.log("Hide")
                visible = false
            }
        }

//        onReleased: {
//            icon_src = "qrc:/Images/StatusBar/btn_done"
//            statusDone = true
//        }
    }

    // Back button
    Button {
        id: backButton
        icon_src: "qrc:/Images/StatusBar/btn_back"
        visible: isShowBackButton
        anchors {
            left: parent.left
            leftMargin: 17.5
            verticalCenter: parent.verticalCenter
        }

        onClicked: backButtonClicked()
    }

    // Time and Date area
    // Time area left
    // Date area right
    Item {
        id: timeDateArea
        width: parent.width * 0.3   // 576
        height: parent.height       // 85
        anchors.centerIn: parent

        // Left divider
        Image {
            source: "qrc:/Images/StatusBar/divider.png"
            anchors.left: parent.left
        }

        // Center divider
        Image {
            id: divider
            source: "qrc:/Images/StatusBar/divider.png"
            anchors.centerIn: parent
        }

        // Right divider
        Image {
            source: "qrc:/Images/StatusBar/divider.png"
            anchors.right: parent.right
        }

        // Time area
        Item {
            id: timeArea

            property alias hour: hour.text      // Hour of current time
            property alias minute: minute.text  // Minute of current time

            width: parent.width / 2 // 288
            height: parent.height   // 85
            anchors.left: parent.left

            // Hour text
            Text {
                id: hour
                color: "#FFFFFF" // White
                font.pixelSize: 60
                font.family: helvetica.name
                anchors.right: colon.left
                anchors.verticalCenter: parent.verticalCenter
            }

            // Colon
            Text {
                id: colon
                text: ":"
                color: "#FFFFFF"// White
                font.pixelSize: 60
                font.family: helvetica.name
                anchors.centerIn: parent
            }

            // flash for colon of time, show seconds
            Timer {
                interval: 500
                repeat: true
                running: true
                onTriggered: {
                    colon.visible = colon.visible === true ? false : true
                }
            }

            // Minute text
            Text {
                id: minute
                color: "#FFFFFF" // White
                font.pixelSize: 60
                font.family: helvetica.name
                anchors.left: colon.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // Date area
        Item {
            id: dateArea

            property alias date: date.text  // Date current

            width: parent.width / 2
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }

            // Date text
            Text {
                id: date
                color: "#FFFFFF"// White
                font.pixelSize: 60
                font.family: helvetica.name
                anchors.centerIn: parent
            }
        }

        // Get time and date current
        // assgin hour current for timeArea.hour - hour format: hh
        // assign minute current for timeArea.minute - minute format: mm
        // assign date current for dateArea.date - date format: MMM. dd
        Timer {
            interval: 5
            repeat: true
            running: true
            onTriggered: {
                var currentTime = new Date()
                timeArea.hour = currentTime.toLocaleTimeString(Qt.locale("en_US"), "hh");
                timeArea.minute = currentTime.toLocaleTimeString(Qt.locale("en_US"), "mm");
                dateArea.date = currentTime.toLocaleDateString(Qt.locale("en_US"), "MMM. dd");
            }
        }
    }

    // System icons area
    Row {
        layoutDirection: Qt.RightToLeft
        spacing: 10
        rightPadding: 17.5
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        // Battery icon
        Image {
            id: battery
            source: "qrc:/Images/StatusBar/indi_battery_4.png"
        }

        // Received Signal Strength Indication : rssi icon
        Image {
            id: rssi
            source: "qrc:/Images/StatusBar/indi_rssi_bt_5.png"
        }

        // Long Term Evolution : lte icon
        Image {
            id: lte
            source: "qrc:/Images/StatusBar/indi_lte_on.png"
        }

        // Wifi icon
        Image {
            id: wifi
            source: "qrc:/Images/StatusBar/indi_wifi_3.png"
        }

        // Bluetooth icon
        Image {
            id: bluetooth
            source: "qrc:/Images/StatusBar/indi_dial_bt_on.png"
        }

        // Speaker icon
        Image {
            id: speaker
            source: "qrc:/Images/StatusBar/indi_audio_off.png"
        }
    }
}
