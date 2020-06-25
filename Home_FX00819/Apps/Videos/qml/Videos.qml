import QtQuick 2.13
import QtQuick.Controls 2.13

Item {
    id: videosApp

    // Font Ubuntu
    FontLoader {
        id: ubuntu
        source: "qrc:/Fonts/Ubuntu-Regular.ttf"
    }

    // 4 = width vertical line on right side list my videos
    ListVideos {
        id: listMyVideos
        width: (parent.width / 3) + 4
        topMargin: 85
        visible: true
        height: parent.height - 85
    }

    // Video player area
    VideoPlayer {
        width: parent.width - listMyVideos.width
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }
    }

    Connections {
        target: statusBar
        onBackButtonClicked: {
            listMyVideos.close()
        }
    }
}
