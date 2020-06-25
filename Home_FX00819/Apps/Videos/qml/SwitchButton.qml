import QtQuick 2.13
import QtMultimedia 5.13

MouseArea {
    id: shuffleButton

    property string icon_on: ""
    property string icon_off: ""
    property bool status: false
    property  alias image: image

    implicitWidth: image.width
    implicitHeight: image.height

    Image {
        id: image
        source: shuffleButton.status ? icon_on : icon_off
    }

    onClicked: {
        if (shuffleButton.status)
            shuffleButton.status = false
        else
            shuffleButton.status = true
    }
}
