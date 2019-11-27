import QtQuick 2.13

MouseArea {
    id: rootWidgetHighlight

    property bool disable: false

    Image {
        id: iconApp
        source: ""
        anchors.fill: parent
    }

    // States: Normal, Focus, and Pressed
    states: [
        State {
            name: "Normal"

            PropertyChanges {
                target: iconApp
                source: ""
            }
        },

        State {
            name: "Focus"

            PropertyChanges {
                target: iconApp
                source: "qrc:/Images/WidgetCommon/bg_widget_f.png"
            }
        },

        State {
            name: "Pressed"

            PropertyChanges {
                target: iconApp
                source: "qrc:/Images/WidgetCommon/bg_widget_p.png"
            }
        }
    ]

    onPressed: {
        if (disable == false)
            rootWidgetHighlight.state = "Pressed"
    }

    onReleased: {
        rootWidgetHighlight.focus = true
        rootWidgetHighlight.state = "Focus"
    }

    onFocusChanged: {
        if (rootWidgetHighlight.focus)
            rootWidgetHighlight.state = "Focus"
        else
            rootWidgetHighlight.state = "Normal"
    }
}
