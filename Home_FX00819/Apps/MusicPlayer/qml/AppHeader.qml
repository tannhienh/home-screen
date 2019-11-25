import QtQuick 2.13

Image {
    id: headerImage

    property alias statusPlaylistButton: playlistButton.status

    signal clickedPlaylistButton(bool playlistStatus)

    source: "qrc:/Apps/MusicPlayer/images/header.png"

    // Open/close Playlist button
    SwitchButton {
        id: playlistButton
        anchors.left: parent.left
        anchors.leftMargin: 20 // parent.width / 100 = 19.2
        anchors.verticalCenter: parent.verticalCenter
        icon_on: "qrc:/Apps/MusicPlayer/images/back.png"
        icon_off: "qrc:/Apps/MusicPlayer/images/drawer.png"
//        m_width: 40 // parent.height * 0.32 = 40
//        m_height: m_width

        onClicked: {
            headerImage.clickedPlaylistButton(status)
        }
    }

    // Playlist text
    Text {
        id: playlistTextButton
        text: qsTr("Playlist")
        color: "White"
        font.pixelSize: 29 // parent.height * 0.23 = 28.75
        font.family: cantarell.name
        anchors.left: playlistButton.right
        anchors.leftMargin: 7 // parent.width / 300 = 6.4
        anchors.verticalCenter: playlistButton.verticalCenter
    }

    // The title of application
    Text {
        id: headerText
        text: qsTr("Media Player")
        font.pixelSize: 44 // parent.height * 0.35 = 43.75
        font.family: cantarell.name
        color: "White"
        anchors.centerIn: parent
    }
}
