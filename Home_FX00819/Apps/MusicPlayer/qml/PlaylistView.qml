import QtQuick 2.13
import QtQuick.Controls 2.13
import QtMultimedia 5.13

Drawer {
    id: drawerPlaylist
    interactive: false
    modal: false

    // Playlist background
    background: Image {
        id: playlistBg
        source: "qrc:/Apps/MusicPlayer/images/playlist_bg.png"
        anchors.fill: parent
    }

    // Velocity of transition for enter and exit playlist
    enter: Transition { SmoothedAnimation { velocity: 2 } }
    exit: Transition { SmoothedAnimation { velocity: 2 } }

    Component {
        id: playlistDelegate

        MouseArea {
            id: mouseAreaItem

            // Visible speaker icon when playing
            function checkPlaying() {
                if (mouseAreaItem.ListView.isCurrentItem)
                    if (player.state === MediaPlayer.PlayingState) {
                        showSpeaker.restart()
                        return true;
                    }
                return false;
            }

            width: playlistItem.width
            height: playlistItem.height

            // Background image of items in playlist
            Image {
                id: playlistItem
                source: "qrc:/Apps/MusicPlayer/images/playlist_item.png"
                width: mediaPlaylist.width
                height: (mediaPlaylist.height - (mediaPlaylist.spacing * 5)) / 6
                opacity: 0.5
            }

            // Speaker image for items in playlist
            // Just visible with song item playing
            Image {
                id: speakerImage
                source: "qrc:/Apps/MusicPlayer/images/playing.png"
                visible: checkPlaying()
                anchors {
                    left: playlistItem.left
                    leftMargin: 10
                    verticalCenter: playlistItem.verticalCenter
                }
            }

            // Name of song
            // Title assigned with "Unknown" if title get from Taglib library
            // is empty
            Text {
                id: songTitle
                text: title == "" ? "Unknown" : title
                color: "#FFFFFF"    // White
                font.pixelSize: playlistItem.height * 0.2
                font.family: cantarell.name
                opacity: mouseAreaItem.ListView.isCurrentItem ? 1 : 0.5
                anchors {
                    left: speakerImage.right
                    leftMargin: 10
                    verticalCenter: playlistItem.verticalCenter
                }
            }

            // Name of single
            Text {
                id: singleName
                text: singer == "" ? "Unknow" : singer
                color: "#FFFFFF"    // White
                font.pixelSize: playlistItem.height * 0.15
                font.family: cantarell.name
                opacity: mouseAreaItem.ListView.isCurrentItem ? 1 : 0.5
                anchors {
                    left: songTitle.left
                    top: songTitle.bottom
                }
            }

            // Change source background image of song item when pressed
            onPressed: {
                playlistItem.source = "qrc:/Apps/MusicPlayer/images/hold.png"
            }

            // Change back source background image of song item when released
            onReleased: {
                playlistItem.source =
                        "qrc:/Apps/MusicPlayer/images/playlist_item.png"
            }

            // Change back source background image of song item when released
            onCanceled: {
                playlistItem.source =
                        "qrc:/Apps/MusicPlayer/images/playlist_item.png"
            }

            // change current index in playlist of player when playlist change
            // current index
            onClicked: {
                if (mediaPlaylist.currentIndex != index) {
                    player.playlist.currentIndex = index
                    changeTitle.restart()
                    showSpeaker.restart()
                }
            }

            // Animation highlight song name current in playlist
            PropertyAnimation {
                id: changeTitle
                target: songTitle
                property: "opacity"
                from: 0.5; to: 1
                duration: 500
                easing.type: Easing.InQuad
            }

            // Animation show speaker icon song item playing
            PropertyAnimation {
                id: showSpeaker
                target: speakerImage
                property: "opacity"
                from: 0; to: 1
                duration: 600
                easing.type: Easing.InQuad
            }
        }
    }

    // Playlist
    ListView {
        id: mediaPlaylist
        anchors.fill: parent
        model: playlistModel
        spacing: 6
        clip: true
        currentIndex: playlist.currentIndex
        snapMode: ListView.SnapToItem
        delegate: playlistDelegate

        // Background image for current item song in playlist
        highlight: Image {
            source: "qrc:/Apps/MusicPlayer/images/playlist_item.png"
        }

        // Scrollbar for playlist
        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylist.parent
            width: 10
            snapMode: ScrollBar.SnapOnRelease
            anchors {
                top: mediaPlaylist.top
                left: mediaPlaylist.right
                bottom: mediaPlaylist.bottom
            }
        }

        // Change current song item in playlist when player change current index
        Connections {
            target: playlist
            onCurrentIndexChanged: mediaPlaylist.currentIndex = index
        }
    }
}
