import QtQuick 2.13

MouseArea {

    // Get focus corresponding widget
    focus: parent.focus

    // Set state "Focus" if focus is true, state "Normal" if focus is false
    state: activeFocus ? "Focus" : "Normal"

    // Disable Pressed state for climate widget
    property bool disablePressed: false

    // High light image source
    Image {
        id: highLightImage
        source: ""
        anchors.fill: parent
    }

    /**
     * - If widget is climate then no change to state Pressed
     * - Focus Climate widget when change focus from Map or Music widget
     * to Climate widget,
     * Else change state to Pressed with Map or Music widget
     */
    onPressed: {
        if (disablePressed) {
            if (!focus)
                parent.focus = true
        } else {
            parent.focus = true
            state = "Pressed"
        }
    }

    // Change state to when released
    onReleased: {
        state = "Focus"
    }

    /**
     * When Enter key was pressed:
     * - Change state to "Pressed" if are Map or Music widget
     * - Nothing if is Climate widget
     */
    Keys.onEnterPressed: {
        if (!disablePressed) {
            state = "Pressed"
            event.accepted = true
        }
    }

    /**
      * Change state when focus was changed:
      * - state "Focus" if focus is true
      * - state "Normal" if focus is false
      */
    onFocusChanged: {
        if (focus)
            state = "Focus"
        else
            state = "Normal"
    }

    // States for widgets: Normal, Focus, and Pressed
    states: [
        State {
            name: "Normal"

            PropertyChanges {
                target: highLightImage
                source: ""
            }
        },

        State {
            name: "Focus"

            PropertyChanges {
                target: highLightImage
                source: "qrc:/Images/WidgetCommon/bg_widget_f.png"
            }
        },

        State {
            name: "Pressed"

            PropertyChanges {
                target: highLightImage
                source: "qrc:/Images/WidgetCommon/bg_widget_p.png"
            }
        }
    ]
}
