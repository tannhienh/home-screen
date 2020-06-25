import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.1

Item {
    id: musicPlayerApp

    implicitHeight: 995

    //------------------------------------------------------------------------//
    // Load Font from attached resource fonts.qrc
    // Font Cantarell
    FontLoader {
        id: cantarell
        source: "qrc:/Fonts/Cantarell-Regular.ttf"
    }
    //------------------------------------------------------------------------//

    Settings {
        id: settings
        property alias playlistVisible: header.statusPlaylist
        property bool checkBackToMain: false
    }

    // Background of Application
    Image {
        id: bgImage
        source: "qrc:/Apps/MusicPlayer/images/background.png"
        anchors.fill: parent
        opacity: 0.7
    }

    // Music Player Header
    AppHeader {
        id: header

        property bool statusPlaylist: false

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 125

        // assign status of playlist to status of playlist button
        statusPlaylistButton: settings.playlistVisible

        // Open playlist view
        onClickedPlaylistButton: {
            if (playlistStatus) {
                playlistView.open()
                statusPlaylist = true
            } else {
                playlistView.close()
                statusPlaylist = false
            }
        }
    }

    PlaylistView {
        id: playlistView
        topMargin: 85 + header.height
        width: 672
        height: musicPlayerApp.height - header.height
    }

    // Main Media
    // width: 1920
    // height: 870
    MediaInfoControl {
        id: mainMedia
        width: parent.width - (playlistView.position * playlistView.width)
        anchors {
            top: header.bottom
            bottom: parent.bottom
            right: parent.right
        }
    }

    Connections {
        target: statusBar
        onBackButtonClicked: {
            settings.checkBackToMain = true
            playlistView.close()
        }
    }

    Component.onCompleted: if (settings.playlistVisible)
                               playlistView.open()
}
