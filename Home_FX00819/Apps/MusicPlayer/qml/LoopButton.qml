import QtQuick 2.13
import QtMultimedia 5.13

// Repeat button - loops playlist or current track
MouseArea {
    id: loopButton

    property string src_sequential:
        "qrc:/Apps/MusicPlayer/images/repeat.png"

    property string src_loop:
        "qrc:/Apps/MusicPlayer/images/repeat_hold.png"

    readonly property int sequential: 0
    readonly property int playlistLoop: 1
    readonly property int currentLoop: 2
    property int status: sequential
    property  alias image: image
    property alias sizeNumber: loopStatus.font.pixelSize

    implicitWidth: image.width
    implicitHeight: image.height

    Image {
        id: image
        source: loopButton.status ? src_loop : src_sequential
    }

    Text {
        id: loopStatus
        text: "1"
        font.family: helvetica.name
        font.pixelSize: 30
        visible: loopButton.status === loopButton.currentLoop
                 ? true : false
        anchors {
            top: loopButton.top
            right: loopButton.right
            rightMargin: 7
        }
    }

    onClicked: {
        if (loopButton.status === loopButton.sequential)
            loopButton.status = loopButton.playlistLoop
        else if (loopButton.status === loopButton.playlistLoop)
            loopButton.status = loopButton.currentLoop
        else if (loopButton.status === loopButton.currentLoop)
            loopButton.status = loopButton.sequential
    }
}
