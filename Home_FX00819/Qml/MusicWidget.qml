import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13
import QtMultimedia 5.13
import "../Apps/MusicPlayer/qml"

Item {
    id: musicPlayerItem

    // Get song title
    // TitleRole: 257
    // If has no song in playlist model return empty string
    // Else, if get a empty string from single name, return "Unknown"
    function getSongTitle() {
        if (playlistModel.rowCount() > 0)
            if (playlistModel.data(playlistModel.index(
                                       playlist.currentIndex, 0), 257) === "")
                return "Unknow"
            else
                return (playlistModel.data(playlistModel.index(
                                               playlist.currentIndex, 0), 257))
        else
            return ""
    }

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

    // Song title and single name
    Item {
        id: infoSongItem
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: albumArtInner.top
        }

        // Title of song
        Text {
            id: songTitle

            text: getSongTitle()

            color: "#FFFFFF"
            font.pixelSize: 40
            font.family: cantarell.name
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 50
            }
        }

        // Name of single
        Text {
            id: singleName
            text: getSingleName()
            color: "#FFFFFF"
            font.pixelSize: 30
            font.family: cantarell.name
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: songTitle.bottom
            }
        }

        DropShadow {
            anchors.fill: songTitle
            source: songTitle
            color: "#aa000000"
            radius: 7
            samples: 15
            horizontalOffset: 2
            verticalOffset: 2
        }

        DropShadow {
            anchors.fill: singleName
            source: singleName
            color: "#aa000000"
            radius: 7
            samples: 15
            horizontalOffset: 2
            verticalOffset: 2
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

    WidgetHighlight {
        id: musicHighlight
        anchors.fill: parent
        onClicked: {
            if (statusBar.editting === false) {
                statusBar.isShowEditButton = false
                openApplication("qrc:/Apps/MusicPlayer/qml/MusicPlayer.qml")
            }
        }
    }

    // Previous button on Music widget
    ButtonControl {
        id: prevButton
        image.width: image.implicitWidth * 0.6
        image.height: image.implicitHeight * 0.6
        anchors.verticalCenter: playButton.verticalCenter
        anchors.right: playButton.left
        anchors.rightMargin: 20
        icon_default: "qrc:/Apps/MusicPlayer/images/prev.png"
        icon_pressed: "qrc:/Apps/MusicPlayer/images/prev_hold.png"
        icon_released: "qrc:/Apps/MusicPlayer/images/prev.png"

        onClicked: {
            if (player.playlist.currentIndex !== 0 || repeatButton.status
                    || shuffleButton.status)
                utility.previous(player);
        }
    }

    // Play/Pause button on Music widget
    ButtonControl {
        id: playButton
        image.width: image.implicitWidth * 0.5
        image.height: image.implicitHeight * 0.5
        anchors.bottom: musicHighlight.bottom
        anchors.bottomMargin: 60
        anchors.horizontalCenter: musicHighlight.horizontalCenter

        status: player.state === MediaPlayer.PlayingState ? true : false

        icon_default: status ? "qrc:/Apps/MusicPlayer/images/pause.png"
                             : "qrc:/Apps/MusicPlayer/images/play.png"
        icon_pressed: status ? "qrc:/Apps/MusicPlayer/images/pause_hold.png"
                             : "qrc:/Apps/MusicPlayer/images/play_hold.png"
        icon_released: status ? "qrc:/Apps/MusicPlayer/images/play.png"
                              : "qrc:/Apps/MusicPlayer/images/pause.png"

        onClicked: {
            if (playButton.status)
                utility.pause(player);
            else
                utility.play(player);
        }

        Connections {
            target: player
            onStateChanged: {
                if (player.state === MediaPlayer.PlayingState)
                    playButton.source_default =
                            "qrc:/Apps/MusicPlayer/images/pause.png"
                else
                    playButton.source_default =
                            "qrc:/Apps/MusicPlayer/images/play.png"
            }
        }
    }

    // Next button on Music widget
    ButtonControl {
        id: nextButton
        image.width: image.implicitWidth * 0.6
        image.height: image.implicitHeight * 0.6
        anchors.verticalCenter: playButton.verticalCenter
        anchors.left: playButton.right
        anchors.leftMargin: 20
        icon_default: "qrc:/Apps/MusicPlayer/images/next.png"
        icon_pressed: "qrc:/Apps/MusicPlayer/images/next_hold.png"
        icon_released: "qrc:/Apps/MusicPlayer/images/next.png"

        onClicked: {
            if (player.playlist.currentIndex !== (playlistModel.rowCount() - 1)
                    || repeatButton.status || shuffleButton.status)
                utility.next(player);
        }
    }

    // Shuffle button on Music widget
    SwitchButton {
        id: shuffleButton
        image.width: image.implicitWidth * 0.6
        image.height: image.implicitHeight * 0.6

        icon_on: "qrc:/Apps/MusicPlayer/images/shuffle_hold.png"
        icon_off: "qrc:/Apps/MusicPlayer/images/shuffle.png"
        status: playlist.playbackMode === Playlist.Random ? 1 : 0

        anchors {
            left: progressBar.left
            verticalCenter: playButton.verticalCenter
        }

        onStatusChanged: {
            if (shuffleButton.status) {
                repeatButton.status = false
                utility.shuffle(player, 1)
            }
            else
                utility.shuffle(player, 0)
        }
    }

    // Repeat button - loops current track
    SwitchButton {
        id: repeatButton
        image.width: image.implicitWidth * 0.6
        image.height: image.implicitHeight * 0.6

        icon_on: "qrc:/Apps/MusicPlayer/images/repeat_hold.png"
        icon_off: "qrc:/Apps/MusicPlayer/images/repeat.png"
        status: playlist.playbackMode === Playlist.Loop ? 1 : 0

        anchors {
            right: progressBar.right
            verticalCenter: playButton.verticalCenter
        }

        onStatusChanged: {
            if (repeatButton.status) {
                shuffleButton.status = false
                utility.loop(player, 1)
            } else
                utility.loop(player, 0)
        }
    }

    ProgressBar {
        id: progressBar
        width: 500
        height: 6
        from: 0.0
        to: player.duration
        value: player.position

        background: Rectangle {
            anchors.fill: parent
            color: "#808080"
            radius: 6
        }

        contentItem: Rectangle {
            width: progressBar.visualPosition * parent.width
            height: parent.height
            color: "#7DEEF8"
            radius: 6
        }

        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 35
        }
    }
}
