import QtQuick 2.13

/*
 * Mouse area for buttons:
 * - Edit Button
 * - Done Button
 * - Back Button
 * - Apps Button in menu
 */
MouseArea {
    id: button

    // Source icon for button
    property var icon_src

    // Title for button with apps button in menu
    property var button_title

    // This property holds whether editting order apps in menu
    property bool editting: false

    // Mouse area on button icon
    implicitWidth: buttonIcon.implicitWidth
    implicitHeight: buttonIcon.implicitHeight

    // Button icon normal default
    Image {
        id: buttonIcon
        source: icon_src === undefined ? "" : icon_src + "_n.png"
    }

    // Title for Application button
    Text {
        id: buttonTitle
        text: button_title === undefined ? "" : button_title
        color: "#FFFFFF"

        font {
            pixelSize: 40
            family: cantarell.name
        }

        anchors {
            bottom: buttonIcon.bottom
            bottomMargin: 90
            horizontalCenter: buttonIcon.horizontalCenter
        }
    }

    // Change state Pressed to Focus if cancel when swip apps list
    onCanceled: if (!statusBar.editting)
                    state = "Focus"

    // States for behavior on button
    states: [
        // State Normal
        State {
            name: "Normal"

            // Change source buttonIcon to normal icon
            PropertyChanges {
                target: buttonIcon
                source: icon_src === undefined ? "" : icon_src + "_n.png"
            }
        },

        // State Focus
        State {
            name: "Focus"

            // Change source buttonIcon focus icon
            PropertyChanges {
                target: buttonIcon
                source: icon_src === undefined ? "" : icon_src + "_f.png"
            }
        },

        // State Pressed
        State {
            name: "Pressed"

            // Change source buttonIcon to pressed icon
            PropertyChanges {
                target: buttonIcon
                source: icon_src + "_p.png"
            }
        }
    ]
}
