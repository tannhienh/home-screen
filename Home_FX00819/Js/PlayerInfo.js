// Get song title
// TitleRole: 257
// If has no song in playlist model return empty string
// Else, if get a empty string from single name, return "Unknown"
function getSongTitle() {
    if (playlistModel.rowCount() > 0) {
        var songTitle = playlistModel.data(playlistModel.index(
                                               playlist.currentIndex, 0), 257)
        if (songTitle !== undefined) {
            if (playlistModel.data(playlistModel.index(
                                       playlist.currentIndex, 0), 257) === "")
                return "Unknow"
            else
                return songTitle
        } else
            return (playlistModel.data(playlistModel.index(
                                           playlistModel.rowCount() - 1, 0), 257))
    }
    else
        return ""
}

// Get Single name of song playing
// SingerRole: 258
// If has no song in playlist model return empty string
// Else, if get a empty string from single name, return "Unknown"
function getSingleName() {
    if (playlistModel.rowCount() > 0) {
        var singleName = playlistModel.data(playlistModel.index(
                                                playlist.currentIndex, 0), 258)
        if (singleName !== undefined){
            if (playlistModel.data(playlistModel.index(
                                       playlist.currentIndex, 0), 258) === "")
                return "Unknow"
            else
                return singleName
        } else
            return (playlistModel.data(playlistModel.index(
                                           playlistModel.rowCount() - 1, 0), 258))
    }
    else
        return ""
}

// Get Album art of song playing
// AlbumArtRole: 260
// If has no song in playlist model return album art default
function getAlbumArt() {
    if (playlistModel.rowCount() > 0) {
        var albumArt = playlistModel.data(playlistModel.index(
                                              playlist.currentIndex, 0), 260)
        if (albumArt !== undefined)
            return albumArt
        else
            return playlistModel.data(playlistModel.index(
                                          playlistModel.rowCount() - 1, 0), 260)
    } else
        return "qrc:/Images/MusicPlayer/cover_art.png"
}
