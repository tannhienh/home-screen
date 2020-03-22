import QtQuick 2.13
import QtQuick.Controls 2.13

// Using Button.qml
import "Common"

/**
 * Status Bar
 * width: 1920
 * height: 85
 */
FocusScope {
    id: statusBarItem

    // This property holds whether the Back button is visible or not
    property bool isShowBackButton: false

    // This property holds whether the Edit button is visible or not
    property bool isShowEditButton: false

    // This alias hold visible property of Done button
    property alias editting: doneButton.visible

    // This signal will be emited when the Back button is clicked
    signal backButtonClicked

    // This signal will be emited when the Edit button is released
    signal editButtonClicked

    // This signal will be emited when the Done button is released
    signal doneButtonClicked

    // Background status bar
    Rectangle {
        id: statusBarBg
        anchors.fill: parent
        color: "#000000" // Black color
        opacity: 0.3

        // Hide virtual keyboard
        MouseArea {
            anchors.fill: parent
            onClicked: focus = true
        }
    }

    // Edit button
    Button {
        id: editButton
        icon_src: "qrc:/Images/StatusBar/btn_edit"
        visible: isShowEditButton
        focus: visible ? statusBar.focus : false

        // Change state to Pressed when Edit button is pressed
        onPressed: state = "Pressed"

        // Change state to Normal when Edit button is Released
        onReleased: state = "Normal"

        /**
          * When Edit button is clicked:
          * - Change focus status bar to false for do not focus Done button
          * - Emit signal editButtonClicked
          * - Hide Edit button
          * - Show Done button
          */
        onClicked: {
            statusBar.focus = false
            editButtonClicked()
            isShowEditButton = false
            doneButton.visible = true
        }

        // When focus changed
        // If which button not focusing, change state to Normal
        onFocusChanged: {
            if (editButton.focus)
                editButton.state = "Focus"
            else
                editButton.state = "Normal"
        }

        /**
         * When Enter key was pressed:
         * - Change state to "Pressed" if are Map or Music widget
         * - Nothing if is Climate widget
         */
        Keys.onReturnPressed: {
            if (event.key === Qt.Key_Return) {
                state = "Pressed"
                statusBar.focus = false
                editButtonClicked()
                isShowEditButton = false
                doneButton.visible = true
            }
        }
    }

    // Done button
    Button {
        id: doneButton
        icon_src: "qrc:/Images/StatusBar/btn_done"
        visible: false
        focus: visible ? statusBar.focus : false
        anchors {
            left: parent.left
            leftMargin: 22
            verticalCenter: parent.verticalCenter
        }

        onPressed: state = "Pressed"

        onReleased: state = "Normal"

        /**
          * When Done button is clicked:
          * - Change focus mainAreStackView from false to true
          * - Emit signal doneButtonClicked
          * - Write apps model to file after change order apps in menu
          * -
          * - Hide Done button
          */
        onClicked: {
            mainAreaStackView.focus = true
            doneButtonClicked()
            xmlWriter.writeToFile()
            xmlReader.reloadModel()
            doneButton.visible = false
        }



        // When focus changed
        // If which button not focusing, change state to Normal
        onFocusChanged: {
            if (doneButton.focus)
                doneButton.state = "Focus"
            else
                doneButton.state = "Normal"
        }

        /**
         * When Enter key was pressed:
         * - Change state to "Pressed" if are Map or Music widget
         * - Nothing if is Climate widget
         */
        Keys.onReturnPressed: {
            if (event.key === Qt.Key_Return) {
                state = "Pressed"
                doneButtonClicked()
                xmlWriter.writeToFile()
                doneButton.visible = false
            }
        }
    }

    // Back button
    Button {
        id: backButton
        icon_src: "qrc:/Images/StatusBar/btn_back"
        visible: isShowBackButton
        focus: visible ? statusBar.focus : false
        anchors {
            left: parent.left
            leftMargin: 18
            verticalCenter: parent.verticalCenter
        }

        onPressed: state = "Pressed"

        onReleased: state = "Normal"

        onClicked: {
            backButtonClicked()
            focus = false
        }

        Keys.onReturnPressed: state = "Pressed"

        Keys.onReleased: {
            if (event.key === Qt.Key_Return) {
                backButtonClicked()
                focus = false
                event.accepted = true
            }
        }

        // When focus changed
        // If which button not focusing, change state to Normal
        onFocusChanged: {
            if (backButton.focus)
                backButton.state = "Focus"
            else
                backButton.state = "Normal"
        }

        Connections {
            target: statusBar
            onFocusChanged: {
                if (isShowBackButton && statusBar.focus)
                    backButton.focus = true
                else
                    backButton.focus = false
            }
        }
    }

    // Time and Date area
    // Time area left
    // Date area right
    Item {
        id: timeDateArea
        width: parent.width * 0.3
        height: parent.height
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

            width: parent.width / 2
            height: parent.height
            anchors.left: parent.left

            // Hour text
            Text {
                id: hour
                color: "#FFFFFF"    // White
                font.pixelSize: 60
                font.family: helvetica.name
                anchors.right: colon.left
                anchors.verticalCenter: parent.verticalCenter
            }

            // Colon
            Text {
                id: colon
                text: ":"
                color: "#FFFFFF"    // White
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
                color: "#FFFFFF"    // White
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
                color: "#FFFFFF"    // White
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
            interval: 16
            repeat: true
            running: true
            onTriggered: {
                var currentTime = new Date()

                timeArea.hour =
                        currentTime.toLocaleTimeString(Qt.locale("en_US"), "hh");

                timeArea.minute =
                        currentTime.toLocaleTimeString(Qt.locale("en_US"), "mm");

                dateArea.date =
                        currentTime.toLocaleDateString(Qt.locale("en_US"), "MMM. dd");
            }
        }
    }

    // System icons area
    Row {
        layoutDirection: Qt.RightToLeft
        spacing: 17
        rightPadding: 18
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
