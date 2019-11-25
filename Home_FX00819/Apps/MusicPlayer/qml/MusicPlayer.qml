import QtQuick 2.13
import QtQuick.Controls 2.13

//import "../../../Qml/"

Item {
    id: playerItem
    implicitHeight: 995 // 1080 - 85

    //-----------------------------------------------------------------------//
    // Load Font from attached resource font.qrc

    // Font Cantarell
    FontLoader {
        id: cantarell
        source: "qrc:/Font/Cantarell-Regular.ttf"
    }
    //-----------------------------------------------------------------------//

    // Background of Application
    Image {
        id: bgImage
        source: "qrc:/Apps/MusicPlayer/images/background.png"
        anchors.fill: parent
        opacity: 0.7
    }

    // Header
    AppHeader {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 125 // parent.height * 0.13 = 129.35

        onClickedPlaylistButton: {
            if (playlistStatus) {
                playlistView.open()

            } else
                playlistView.close()
        }
    }

    Connections {
        target: statusBar
        onBackButtonClicked: playlistView.close()
    }

    PlaylistView {
        id: playlistView
        topMargin: 85 + header.height // 85 + 125 = 210
        width: 672 // playerItem.width * 0.35 = 672
        height: playerItem.height - header.height // 995 - 125 = 870
    }

    // Main Media
    // width: 1920
    // height: 870
    MediaInfoControl {
        id: mainMedia
        anchors.top: header.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        width: parent.width - (playlistView.position * playlistView.width)
    }
}
