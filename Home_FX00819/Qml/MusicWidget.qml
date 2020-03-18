import QtQuick 2.13
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13
import QtMultimedia 5.13

// Components for Music player app
import "../Apps/MusicPlayer/qml"

// Javascript functions controls and get info Music player
import "../Js/Player.js" as Player

// Javascript common function
import "../Js/Common.js" as Common

FocusScope {
    id: musicPlayerItem

    // Album art background
    Image {
        id: albumArtBg
        anchors.fill: parent
        source: Player.getAlbumArt()
    }

    // Blue effect for album art background
    FastBlur {
        anchors.fill: albumArtBg
        source: albumArtBg
        radius: 15
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
            id: songName

            text: Player.getSongTitle()

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
            text: Player.getSingleName()
            color: "#FFFFFF"
            font.pixelSize: 30
            font.family: cantarell.name
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: songName.bottom
            }
        }

        DropShadow {
            anchors.fill: songName
            source: songName
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

    // Delegate for album art view
    Component {
        id: albumArtDelegate

        Item {

            property variant getData: model

            width: albumArtBoder.width
            height: albumArtBoder.height
            scale: PathView.iconScale === undefined ? 0 : PathView.iconScale

            Image {
                id: albumPicture
                source: album_art
                width: albumArtBoder.width
                height: albumArtBoder.height
                anchors.centerIn: parent
            }

            Image {
                id: albumArtBoder
                source: "qrc:/Images/MusicPlayer/album_art_borders.png"
                anchors.centerIn: parent
            }
        }
    }

    // AlbumArt View
    PathView {
        id: albumArtInner
        anchors.fill: parent
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        model: playlistModel
        delegate: albumArtDelegate
        pathItemCount: 1
        currentIndex: playlist.currentIndex

        path: Path {

            startX: 0
            startY: albumArtInner.height / 2
            PathAttribute { name: "iconScale"; value: 0.5 }

            PathLine {
                x: albumArtInner.width / 2
                y: albumArtInner.height / 2
            }
            PathAttribute { name: "iconScale"; value: 1.0 }

            PathLine {
                x: albumArtInner.width
                y: albumArtInner.height / 2
            }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }
    }

    // Highlight for music widget
    WidgetHighlight {
        id: musicHighlight
        anchors.fill: parent

        // Open Music application
        onClicked: Common.openApp("qrc:/Apps/MusicPlayer/qml/MusicPlayer.qml")
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

        onClicked: Player.previousPlayer()
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

        onClicked: Player.nextPlayer()
    }

    // Shuffle button on Music widget
    SwitchButton {
        id: shuffleButton
        image.width: image.implicitWidth * 0.6
        image.height: image.implicitHeight * 0.6
        icon_on: "qrc:/Apps/MusicPlayer/images/shuffle_hold.png"
        icon_off: "qrc:/Apps/MusicPlayer/images/shuffle.png"
        status: shuffleGlobal

        anchors {
            left: progressBar.left
            verticalCenter: playButton.verticalCenter
        }

        onStatusChanged: {
            shuffleGlobal = shuffleButton.status
            utility.setPlayerMode(player, shuffleButton.status,
                                  loopButton.status)
        }
    }

    LoopButton {
        id: loopButton
        image.width: image.implicitWidth * 0.6
        image.height: image.implicitHeight * 0.6
        sizeNumber: 20
        status: loopGlobal

        anchors {
            right: progressBar.right
            verticalCenter: playButton.verticalCenter
        }

        onStatusChanged: {
            loopGlobal = loopButton.status
            utility.setPlayerMode(player, shuffleButton.status,
                                  loopButton.status)
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

    Connections {
        target: root
        onShuffleGlobalChanged: shuffleButton.status = shuffleGlobal
        onLoopGlobalChanged: loopButton.status = loopGlobal
    }
}
