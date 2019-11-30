import QtQuick 2.13

MouseArea {
    id: button

    // Source icon
    property string icon_src

    // Title for button
    property string button_title

    // Mouse area on button icon
    implicitWidth: buttonIcon.implicitWidth
    implicitHeight: buttonIcon.implicitHeight

    // Button icon normal default
    Image {
        id: buttonIcon
        source: icon_src + "_n.png"
    }

    // Title for Application button
    Text {
        id: buttonTitle
        text: button_title
        color: "White"
        font {
            pixelSize: 40
            family: cantarell.name
        }
        anchors {
            bottom: parent.bottom
            bottomMargin: 90
            horizontalCenter: parent.horizontalCenter
        }
    }

    // States for behavior on button
    states: [
        // State Normal
        State {
            name: "Normal"

            // Change source buttonIcon to normal icon
            PropertyChanges {
                target: buttonIcon
                source: icon_src + "_n.png"
            }
        },

        // State Focus
        State {
          name: "Focus"

          // Change source buttonIcon focus icon
          PropertyChanges {
              target: buttonIcon
              source: icon_src + "_f.png"
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

    // Change state to Pressed when pressed behavior
    onPressed: {
        button.focus = true
        button.state = "Pressed"
        if (onFlicEnded)
            console.log("Ended")

    }

    // Change state to Pressed when focus behavior
    onReleased: {
        button.focus = true
        button.state = "Focus"
    }

    onCanceled: {
        button.focus = true
        button.state = "Focus"
    }

    // When focus changed
    // If which button not focusing, change state to Normal
    onFocusChanged: {
        if (button.focus == true )
            button.state = "Focus"
        else
            button.state = "Normal"
    }
}
