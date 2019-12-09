import QtQuick 2.13

Image {
    id: headerImage

    // This property hold status of playlist opened
    // to show matching playlist button
    property alias statusPlaylistButton: playlistButton.status

    // signal when clicked on playlist button
    signal clickedPlaylistButton(bool playlistStatus)

    source: "qrc:/Apps/MusicPlayer/images/header.png"

    // Open/close Playlist button
    SwitchButton {
        id: playlistButton
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        icon_on: "qrc:/Apps/MusicPlayer/images/back.png"
        icon_off: "qrc:/Apps/MusicPlayer/images/drawer.png"

        onClicked: headerImage.clickedPlaylistButton(status)
    }

    // Playlist text
    Text {
        id: playlistTextButton
        text: qsTr("Playlist")
        color: "White"
        font.pixelSize: 29
        font.family: cantarell.name
        anchors.left: playlistButton.right
        anchors.leftMargin: 7
        anchors.verticalCenter: playlistButton.verticalCenter
    }

    // The title of application
    Text {
        id: headerText
        text: qsTr("Media Player")
        font.pixelSize: 44
        font.family: cantarell.name
        color: "White"
        anchors.centerIn: parent
    }
}
