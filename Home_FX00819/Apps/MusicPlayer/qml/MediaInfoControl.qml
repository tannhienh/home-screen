import QtQuick 2.13
import QtQuick.Controls 2.13
import QtMultimedia 5.13
import QtGraphicalEffects 1.13

Item {

    // Media Info
    Item {
        id: mediaInfo
        height: 104 // parent.height * 0.12 // 870 * 0.12 = 104.4
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        // Dark effect on top media info
        Rectangle {
            anchors.fill: parent

            gradient: Gradient {
                GradientStop {
                    position: -0.5
                    color: "#FF000000"
                }

                GradientStop {
                    position: 1
                    color: "#00000000"
                }
            }
        }

        // Song title
        Text {
            id: songTitle
            color: "#FFFFFF"
            font.pixelSize: 33 // mediaInfo.height * 0.32 = 33.28
            font.family: cantarell.name

            text: {
                if (playlistModel.rowCount() > 0)
                    return (albumArtView.currentItem.getData.title === ""
                            ? "Unknown" : albumArtView.currentItem.getData.title)
                  else
                    return ""
            }

            anchors {
                top: parent.top
                topMargin: 14 // mediaInfo.height * 0.14 = 14.56
                left: parent.left
                leftMargin: 27 // mediaInfo.width / 70 = 27.4
            }
        }

        // Singer
        Text {
            id: songSinger

            color: "#D3D3D3"
            font.pixelSize: 28 // mediaInfo.height * 0.27
            font.family: cantarell.name

            text: {
                if (playlistModel.rowCount() > 0)
                    return (albumArtView.currentItem.getData.singer === ""
                            ? "Unknown" : albumArtView.currentItem.getData.singer)
                  else
                    return ""
            }

            anchors {
                top: songTitle.bottom
                left: parent.left
                leftMargin: 27 // mediaInfo.width / 70
            }
        }

        // Icon Amount of song
        Image {
            id: counterIcon
            source: "qrc:/Apps/MusicPlayer/images/music.png"
//            height: 38 //mediaInfo.height * 0.35 = 36.4
//            width: height
            anchors {
                right: songAmount.left
                rightMargin: 10 // mediaInfo.height * 0.1 = 10.4
                verticalCenter: mediaInfo.verticalCenter
            }
        }

        // Amount of song in playlist
        Text {
            id: songAmount
            text: albumArtView.count
            color: "#FFFFFF"
            font.pixelSize: 37 // mediaInfo.height * 0.35 = 36.4
            font.family: cantarell.name
            anchors {
                right: mediaInfo.right
                rightMargin: 25 // mediaInfo.height * 0.2 = 20.8
                verticalCenter: mediaInfo.verticalCenter
            }
        }
    }

    // Album Art Item
    Item {
        id: albumArtItem
//        height: 543 // parent.height * 0.6 = 522
        anchors {
            top: mediaInfo.bottom
            left: parent.left
            right: parent.right
            bottom: progressBarItem.top
        }

        // Delegate for album art view
        Component {
            id: albumArtDelegate

            Item {

                property variant getData: model

                width: albumArtItem.height * 0.65
                height: width
                scale:  PathView.iconScale === undefined ? 0 : PathView.iconScale
                opacity: PathView.isCurrentItem ? 1 : 0.8

                Image {
                    id: albumPicture
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: album_art
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: if (player.playlist.currentIndex != index)
                                    player.playlist.currentIndex = index
                }

                DropShadow {
                    anchors.fill: albumPicture
                    color: "#aa000000"
                    radius: 80
                    samples: 100
                    horizontalOffset: 20
                    verticalOffset: 80
                    spread: 0
                    source: albumPicture
                }

                transform: Scale {
                    origin.x: 0.5
                    origin.y: 0.5
                }
            }
        }

        // AlbumArt View
        PathView {
            id: albumArtView

            property int playingIndex


            anchors.fill: albumArtItem
            anchors.leftMargin: (albumArtItem.width -
                                 (albumArtItem.height * 1.8)) / 2
            preferredHighlightBegin: 0.5
            preferredHighlightEnd: 0.5
            focus: true
            model: playlistModel
            delegate: albumArtDelegate
            pathItemCount: 3
            currentIndex: playlist.currentIndex

            path: Path {
                startX: 0
                startY: albumArtItem.height * 0.45
                PathAttribute { name: "iconScale"; value: 0.5 }
                PathLine {
                    x: albumArtItem.height * 0.9
                    y: albumArtItem.height * 0.45
                }
                PathAttribute { name: "iconScale"; value: 1.0 }
                PathLine {
                    x: albumArtItem.height * 1.8
                    y: albumArtItem.height * 0.45
                }
                PathAttribute { name: "iconScale"; value: 0.5 }
            }

            onCurrentIndexChanged: {
                if (settings.checkBackToMain) {
                    albumArtView.currentIndex = currentIndex
                    player.playlist.currentIndex = currentIndex
                }
                changeText.targets = [songTitle, songSinger]
                changeText.restart()
            }

            PropertyAnimation {
                id: changeText
                property: "opacity"
                from: 0; to: 1
                duration: 500
                easing.type: Easing.InOutCubic
            }
        }

        Connections {
            target: playlist
            onCurrentIndexChanged: {
                albumArtView.currentIndex = index
            }
        }
    }

    // ProgressBar
    Item {
        id: progressBarItem
        height: 43 // parent.height / 20 = 43.5
        anchors {
//            top: albumArtItem.bottom
            left: parent.left
            bottom: mediaControl.top
            right: parent.right
        }

        // Current time playing
        Text {
            id: currentTime
            text: utility.getTimeInfo(player.position)
            color: "#FFFFFF"
            font.pixelSize: 17 // parent.height * 0.4 = 17
            font.family: cantarell.name
            anchors {
                left: progressBarItem.left
                leftMargin: 150
                verticalCenter: progressBar.verticalCenter
            }
        }

        Slider{
            id: progressBar
            from: 0.0
            to: player.duration
            value: player.position
            anchors {
                left: currentTime.right
                leftMargin: 20
                right: totalTime.left
                rightMargin: 20
                verticalCenter: progressBarItem.verticalCenter
            }

            background: Rectangle {
                x: progressBar.leftPadding
                y: progressBar.topPadding + (progressBar.availableHeight / 2)
                   - (height / 2)
                width: progressBar.availableWidth
                height: 6 // progressBarItem.height * 0.127
                radius: height
                color: "#808080"

                Rectangle {
                    width: progressBar.visualPosition * parent.width
                    height: parent.height
                    color: "#FFFFFF"
                    radius: 6
                }
            }

            handle: Image {
                id: point
                source: "qrc:/Apps/MusicPlayer/images/point.png"
//                width: progressBarItem.height * 0.5
//                height: width + 2
                anchors.verticalCenter: parent.verticalCenter
                x: progressBar.leftPadding + progressBar.visualPosition *
                   (progressBar.availableWidth - width / 2)
                y: progressBar.topPadding + (progressBar.availableHeight / 2)
                   - height / 2
                Image {
                    id: centerPoint
                    anchors.centerIn: parent
                    source: "qrc:/Apps/MusicPlayer/images/center_point.png"
//                    width: point.width * 0.7
//                    height: width
                }
            }

            onPressedChanged: {
                player.setPosition(Math.floor(position * player.duration))
            }
        }

        // Total time of song
        Text {
            id: totalTime
            text: utility.getTimeInfo(player.duration)
            font.family: cantarell.name
            color: "#FFFFFF"
            font.pixelSize: parent.height * 0.4
            anchors {
                right: progressBarItem.right
                rightMargin: 150
                verticalCenter: progressBar.verticalCenter
            }
        }
    }

    // Media Control
    Item {
        id: mediaControl
        height: 145 // parent.height / 6
        anchors {
            left: parent.left
            bottom: parent.bottom
            right: parent.right
            bottomMargin: 35 // parent.height / 25
        }

        // Previous button
        ButtonControl {
            id: prevButton
//            m_height: mediaControl.height * 0.37 // 89
//            m_width: m_height * 1.51 // 59
            anchors.right: playButton.left
            anchors.verticalCenter: playButton.verticalCenter
            icon_default: "qrc:/Apps/MusicPlayer/images/prev.png"
            icon_pressed: "qrc:/Apps/MusicPlayer/images/prev_hold.png"
            icon_released: "qrc:/Apps/MusicPlayer/images/prev.png"

            onClicked: {
                if (player.playlist.currentIndex !== 0 || repeatButton.status
                    || shuffleButton.status)
                    utility.previous(player);
            }
        }

        // Play/Pause button
        ButtonControl {
            id: playButton
//            m_height: mediaControl.height * 0.85 // 132
//            m_width: m_height - 1 // 133
            anchors.centerIn: mediaControl

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

        // Next button
        ButtonControl {
            id: nextButton
//            m_width: prevButton.m_width // 89
//            m_height: prevButton.m_height // 59
            anchors.left: playButton.right
            anchors.verticalCenter: playButton.verticalCenter
            icon_default: "qrc:/Apps/MusicPlayer/images/next.png"
            icon_pressed: "qrc:/Apps/MusicPlayer/images/next_hold.png"
            icon_released: "qrc:/Apps/MusicPlayer/images/next.png"

            onClicked: {
                if (player.playlist.currentIndex !== (albumArtView.count - 1)
                        || repeatButton.status || shuffleButton.status)
                    utility.next(player);
            }
        }

        // Shuffle button
        SwitchButton {
            id: shuffleButton
            icon_on: "qrc:/Apps/MusicPlayer/images/shuffle_hold.png"
            icon_off: "qrc:/Apps/MusicPlayer/images/shuffle.png"
            status: playlist.playbackMode === Playlist.Random ? 1 : 0

//            m_height: mediaControl.height * 0.33 // 108
//            m_width: m_height * 2.04  // 53
            anchors {
                left: mediaControl.left
                leftMargin: 150
                verticalCenter: mediaControl.verticalCenter
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

            icon_on: "qrc:/Apps/MusicPlayer/images/repeat_hold.png"
            icon_off: "qrc:/Apps/MusicPlayer/images/repeat.png"
            status: playlist.playbackMode === Playlist.Loop ? 1 : 0

//            m_width: shuffleButton.width // 108
//            m_height: shuffleButton.height // 53
            anchors {
                right: mediaControl.right
                rightMargin: 150
                verticalCenter: mediaControl.verticalCenter
            }

            onStatusChanged: {
                if (repeatButton.status) {
                    shuffleButton.status = false
                    utility.loop(player, 1)
                } else
                    utility.loop(player, 0)
            }
        }
    }
}
