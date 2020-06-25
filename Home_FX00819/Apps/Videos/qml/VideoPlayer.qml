import QtQuick 2.13
import QtMultimedia 5.13
import QtQuick.Controls 2.13

import "../../../Js/Player.js" as Player

Item {

    // Video title
    Item {
        id: videoTitleItem
        width: parent.width
        height: 60

        Text {
            id: videoTitle
            text: Player.getSongTitle()
            color: "#FFFFFF"
            font.pixelSize: 40
            font.family: ubuntu.name
            anchors {
                left: parent.left
                leftMargin: 20
                verticalCenter: parent.verticalCenter
            }
        }
    }

    // Background Video screen
    Rectangle {
        id: videoScreen
        width: parent.width
        height: 710
        opacity: 0.8
        color: "#1b1b1b"
        anchors.top: videoTitleItem.bottom

        // Hide virtual Keyboard
        MouseArea {
            anchors.fill: parent
            onClicked: {
                focus = true
            }
        }

        // Video icon
        Image {
            id: videoIcon
            source: "qrc:/Apps/Videos/images/video_icon.png"
            anchors.centerIn: parent
            visible: true
        }
    }

    // Video progress bar
    Item {
        id: videoProgressBarItem
        width: parent.width
        height: 50
        anchors.top: videoScreen.bottom

        // Current time playing
        Text {
            id: currentTime
            text: utility.getTimeInfo(player.position)
            color: "#FFFFFF"
            font.pixelSize: 17
            font.family: cantarell.name
            anchors {
                left: parent.left
                leftMargin: 150
                verticalCenter: parent.verticalCenter
            }
        }

        // Progress bar
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
                verticalCenter: parent.verticalCenter
            }

            background: Rectangle {
                x: progressBar.leftPadding
                y: progressBar.topPadding + (progressBar.availableHeight / 2)
                   - (height / 2)
                width: progressBar.availableWidth
                height: 6
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
                source: "qrc:/Apps/Videos/images/point.png"
                anchors.verticalCenter: parent.verticalCenter
                x: progressBar.leftPadding + progressBar.visualPosition *
                   (progressBar.availableWidth - width / 2)
                y: progressBar.topPadding + (progressBar.availableHeight / 2)
                   - height / 2
                Image {
                    id: centerPoint
                    anchors.centerIn: parent
                    source: "qrc:/Apps/Videos/images/center_point.png"
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
                right: parent.right
                rightMargin: 150
                verticalCenter: progressBar.verticalCenter
            }
        }
    }

    // Video controls
    Item {
        id: videoControls
        width: parent.width
        anchors {
            top: videoProgressBarItem.bottom
            bottom: parent.bottom
        }

        // Previous button
        ButtonControl {
            id: prevButton
            anchors.right: playButton.left
            anchors.verticalCenter: playButton.verticalCenter
            icon_default: "qrc:/Apps/Videos/images/prev.png"
            icon_pressed: "qrc:/Apps/Videos/images/prev_hold.png"
            icon_released: "qrc:/Apps/Videos/images/prev.png"

            onClicked: Player.previousPlayer()
        }

        // Play/Pause button
        ButtonControl {
            id: playButton
            anchors.centerIn: parent

            status: player.state === MediaPlayer.PlayingState ? true : false
            icon_default: status ? "qrc:/Apps/Videos/images/pause.png"
                                 : "qrc:/Apps/Videos/images/play.png"
            icon_pressed: status ? "qrc:/Apps/Videos/images/pause_hold.png"
                                 : "qrc:/Apps/Videos/images/play_hold.png"
            icon_released: status ? "qrc:/Apps/Videos/images/play.png"
                                  : "qrc:/Apps/Videos/images/pause.png"

            onClicked: {
                if (this.status)
                    utility.pause(player);
                else
                    utility.play(player);
            }

            Connections {
                target: player
                onStateChanged: {
                    if (player.state === MediaPlayer.PlayingState)
                        playButton.source_default =
                                "qrc:/Apps/Videos/images/pause.png"
                    else
                        playButton.source_default =
                                "qrc:/Apps/Videos/images/play.png"
                }
            }
        }

        // Next button
        ButtonControl {
            id: nextButton
            anchors.left: playButton.right
            anchors.verticalCenter: playButton.verticalCenter
            icon_default: "qrc:/Apps/Videos/images/next.png"
            icon_pressed: "qrc:/Apps/Videos/images/next_hold.png"
            icon_released: "qrc:/Apps/Videos/images/next.png"

            onClicked: Player.nextPlayer()
        }

        // Shuffle button
        SwitchButton {
            id: shuffleButton
            icon_on: "qrc:/Apps/MusicPlayer/images/shuffle_hold.png"
            icon_off: "qrc:/Apps/MusicPlayer/images/shuffle.png"
//            status: shuffleGlobal
            visible: false

            anchors {
                left: parent.left
                leftMargin: 150
                verticalCenter: playButton.verticalCenter
            }

            onStatusChanged: {
//                shuffleGlobal = shuffleButton.status
                utility.setPlayerMode(player, shuffleButton.status,
                                      loopButton.status)
            }
        }

        // Repeat button - loops playlist or current track
        LoopButton {
            id: loopButton
            visible: false
//            status: loopGlobal
            anchors {
                right: parent.right
                rightMargin: 150
                verticalCenter: playButton.verticalCenter
            }

            onStatusChanged: {
//                loopGlobal = loopButton.status
                utility.setPlayerMode(player, shuffleButton.status,
                                      loopButton.status)
            }
        }

        // Full screen icon
        Image {
            id: fullScreen

            property bool status: false
            property var prefix_fullScreen: "qrc:/Apps/Videos/images/"

            anchors {
                right: parent.right
                rightMargin: 30
                verticalCenter: parent.verticalCenter
            }

            source: this.status ? prefix_fullScreen + "fullscreen_exit.png"
                                : prefix_fullScreen + "full_screen.png"

            MouseArea {
                anchors.fill: parent
                onClicked: if (fullScreen.status) {
                               fullScreen.status = false
                           } else {
                               fullScreen.status = true
                           }
            }
        }
    }
}
