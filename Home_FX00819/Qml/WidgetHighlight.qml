import QtQuick 2.13

MouseArea {
    id: root
    focus: parent.focus
    state: activeFocus ? "Focus" : "Normal"

    // Disable Pressed state for climate widget
    property bool disablePressed: false

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

    onReleased: {
        state = activeFocus ? "Focus" : "Normal"
    }

    onFocusChanged: {
        if (focus)
            state = "Focus"
        else
            state = "Normal"
    }

    // States: Normal, Focus, and Pressed
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
