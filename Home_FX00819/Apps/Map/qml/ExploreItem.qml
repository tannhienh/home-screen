import QtQuick 2.0

Rectangle {
    id: rectItem

    property string src: ""
    property string title: ""

    width: (parent.width - (20 * 2)) / 3
    height: parent.height
    radius: 4

    Component.onCompleted: {
        console.log("Width: " + rectItem.width)
        console.log("Height: " + rectItem.height)
    }

    Image {
        source: src
        anchors.centerIn: parent
    }

    Text {
        text: title
        color: "#515356"
        font.pixelSize: 20
        anchors {
            bottom: parent.bottom
            bottomMargin: 5
            horizontalCenter: parent.horizontalCenter
        }
    }

    MouseArea {
        anchors.fill: parent

        onPressed: {
           parent.opacity = 0.6
        }

        onReleased: parent.opacity = 1.0
        onCanceled: parent.opacity = 1.0
    }
}
