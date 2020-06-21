import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.VirtualKeyboard 2.13
//import QtQuick.VirtualKeyboard.Styles 2.13
//import QtQuick.VirtualKeyboard.Settings 2.13

Item {

    //        Item {
    //            id: keyboardArea
    //            anchors.fill: parent
    //        }

    Rectangle {
        id: keyboardArea
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

    TextField {
        id: phoneNumberInput
        width: 400
        height: 70
        color: "#2B2C2E"
        selectionColor: Qt.rgba(0.0, 0.0, 0.0, 0.15)
        selectedTextColor: color
        selectByMouse: true
        font.pixelSize: 40
        placeholderText: "Enter phone number"
        horizontalAlignment: Text.AlignHCenter
        focus: true
        inputMethodHints: Qt.ImhDialableCharactersOnly

        anchors {
            top: parent.top
            topMargin: parent.height / 10
            horizontalCenter: parent.horizontalCenter
        }
        validator: RegExpValidator { regExp: /^[0-9\+\-\#\*\ ]{6,}$/ }
    }

    InputPanel {
        id: keyboardPhoneNumber
        width: phoneNumberInput.width * 5
        active: true
        visible: true

        anchors {
            top: phoneNumberInput.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: parent.height / 10
        }

        Component.onCompleted: {
            // the keyboard background
            keyboard.style.keyboardBackground = null

            // horizontal bar at the top of the keyboard
            keyboard.style.selectionListBackground = null
        }
    }

    Component.onCompleted: phoneNumberInput.focus = true
}
