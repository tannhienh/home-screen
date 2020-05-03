import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.VirtualKeyboard 2.13
import QtQuick.VirtualKeyboard.Styles 2.13
import QtGraphicalEffects 1.13
import QtQuick.VirtualKeyboard.Settings 2.13

Item {
    id: phoneItem

    Rectangle {
        id: listContacts
        width: parent.width / 3
        opacity: 0.8
        anchors {
            top: parent.top
            left: parent.left
            bottom: parent.bottom
        }
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: "#2B2E30" }
            GradientStop { position: 1; color: "#4A4A4A" }
        }
    }

    Rectangle {
        id: line
        width: 3
        color: "#5D6164"
        anchors {
            top: parent.top
            left: listContacts.right
            bottom: parent.bottom
        }
    }

    Item {

        anchors {
            top: parent.top
            left: line.right
            right: parent.right
            bottom: parent.bottom
            margins: 40
        }

        //        Item {
        //            id: keyboardArea
        //            anchors.fill: parent
        //        }

        Rectangle {
            id: keyboardArea
            opacity: 0.8
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0; color: "#2B2E30" }
                GradientStop { position: 0.5; color: "#121213" }
                GradientStop { position: 1; color: "#2B2E30" }
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

                // the horizontal bar at the top of the keyboard
                keyboard.style.selectionListBackground = null
            }

        }
    }

    Component.onCompleted: phoneNumberInput.focus = true
}
