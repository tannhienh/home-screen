import QtQuick 2.13
import QtQuick.Controls 2.13
//import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.13
import QtMultimedia 5.13

Item {
    id: musicPlayerItem

    // Get Single name of song playing
    // SingerRole: 258
    // If has no song in playlist model return empty string
    // Else, if get a empty string from single name, return "Unknown"
    function getSingleName() {
        if (playlistModel.rowCount() > 0)
            if (playlistModel.data(playlistModel.index(
                                       playlist.currentIndex, 0), 258) === "")
                return "Unknow"
            else
                return (playlistModel.data(playlistModel.index(
                                               playlist.currentIndex, 0), 258))
        else
            return ""
    }

    // Get Album art of song playing
    // AlbumArtRole: 260
    // If has no song in playlist model return album art default
    function getAlbumArt() {
        if (playlistModel.rowCount() > 0)
            return playlistModel.data(playlistModel.index(
                                          playlist.currentIndex, 0), 260)
        else
            return "qrc:/Images/MusicPlayer/cover_art.png"
    }

    // Album art background
    Image {
        id: albumArtBg
        anchors.fill: parent
        source: getAlbumArt()
    }

    // Blue effect for album art background
    FastBlur {
        anchors.fill: albumArtBg
        source: albumArtBg
        radius: 10
    }

    // Title music widget: source audios
    Item {
        id: titleItem
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: albumArtInner.top
        }

        Text {
            id: title
            text: "USB Music"
            color: "#FFFFFF"
            font.pixelSize: 30
            font.family: ubuntu.name
            anchors.centerIn: parent
        }
    }

    Image {
        id: albumArtInner
        source: albumArtBg.source
        width: albumArtBoder.width
        height: albumArtBoder.height
        anchors.centerIn: parent
    }

    Image {
        id: albumArtBoder
        source: "qrc:/Images/MusicPlayer/widget_music_player_album_art_borders.png"
        anchors.centerIn: parent
    }

    Text {
        id: single
        text: getSingleName()
        color: "#FFFFFF"
        font.pixelSize: 30
        font.family: cantarell.name
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 110
        }
    }

    Text {
        id: songTitle

        // TitleRole: 257
        text: if (playlistModel.rowCount() > 0)
                  if (playlistModel.data(playlistModel.index(
                                        playlist.currentIndex, 0), 257) === "")
                      return "Unknow"
                  else
                    return (playlistModel.data(playlistModel.index(
                                          playlist.currentIndex, 0), 257))
              else
                  return ""

        color: "#FFFFFF"
        font.pixelSize: 40
        font.family: cantarell.name
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 50
        }
    }

    ProgressBar {
        id: progressBar
        width: 500
        height: 5
        from: 0.0
        to: player.duration
        value: player.position

        background: Rectangle {
            anchors.fill: parent
            color: "#808080"
            radius: 5
        }

        contentItem: Rectangle {
            width: progressBar.visualPosition * parent.width
            height: parent.height
            color: "#7DEEF8"
            radius: 5
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 30
        }
    }
}
