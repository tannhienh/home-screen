import QtQuick 2.13

MouseArea {
    id: root

    property string icon_on: ""
    property string icon_off: ""
    property bool status: false
    property  alias image: image

    implicitWidth: image.width
    implicitHeight: image.height

    Image {
        id: image
        source: root.status === true ? icon_on : icon_off
    }

    onClicked: {
        if (root.status)
            root.status = false
        else
            root.status = true
    }
}
