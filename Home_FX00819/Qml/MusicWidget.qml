import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.13
import QtMultimedia 5.13

Item {
    id: musicPlayerItem

    Image {
        id: albumArtBg
        anchors.fill: parent

        // AlbumArtRole: 260
        source: if (playlistModel.rowCount() > 0)
                    return playlistModel.data(playlistModel.index(
                                            playlist.currentIndex, 0), 260)
                else
                    return "qrc:/Images/MusicPlayer/cover_art.png"
    }

    FastBlur {
        anchors.fill: albumArtBg
        source: albumArtBg
        radius: 10
    }

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
            color: "White"
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

        // SingerRole: 258
        text: if (playlistModel.rowCount() > 0)
                  if (playlistModel.data(playlistModel.index(
                                        playlist.currentIndex, 0), 258) === "")
                      return "Unknow"
                  else
                      return (playlistModel.data(playlistModel.index(
                                                playlist.currentIndex, 0), 258))
              else
                  return ""

        color: "White"
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

        color: "White"
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
            color: "#7deef8"
            radius: 5
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 30
        }
    }
}
