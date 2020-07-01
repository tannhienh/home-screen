import QtQuick 2.13

Item {
    id: itemRoot

    property string src: ""
    property string title: ""
    property string colorItem: ""

    width: 100
    height: 133

    Rectangle {
        id: rectItem

        width: 100
        height: 100
        color: parent.colorItem
        radius: width

        Image {
            source: itemRoot.src
            anchors.centerIn: parent
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

    Text {
        text: itemRoot.title
        color: "#FFFFFF"
        font.pixelSize: 24
        font.family: cantarell.name
        anchors {
            top: rectItem.bottom
            horizontalCenter: rectItem.horizontalCenter
        }
    }
}
