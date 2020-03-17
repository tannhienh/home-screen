/**
 *Get song title
 * TitleRole: 257
 * If has no song in playlist model return empty string
 * Else, if get a empty string from single name, return "Unknown"
 */
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

/**
 * Get Single name of song playing
 * SingerRole: 258
 * If has no song in playlist model return empty string
 * Else, if get a empty string from single name, return "Unknown"
 */
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

/**
 * Get Album art of song playing
 * AlbumArtRole: 260
 * If has no song in playlist model return album art default
 */
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

/**
  * Previous when:
  * - loop playlist
  * - random
  * - sequential and not First list
  * - loop current and not Firsr list
  *
  * No Previous when:
  * - loop current and First list
  * - sequential and First list
  */
function previousPlayer()
{
    if (playlist.playbackMode === Playlist.Random) {
        do {
            var temp = player.playlist.currentIndex
            utility.previous(player)
        } while (player.playlist.currentIndex  === temp)
    } else if (playlist.playbackMode === Playlist.Loop
               || (shuffleButton.status
                   && (loopButton.status === 2)
                   && (player.playlist.currentIndex !== 0))) {
        utility.previous(player)
    } else if ((player.playlist.currentIndex !== 0)
               && !shuffleButton.status && (loopButton.status !== 1)) {
        utility.previous(player)
    }
}

/**
  * Next when:
  * - loop playlist
  * - random
  * - sequential and not End list
  * - loop current and not End list
  *
  * No Next when:
  * - loop current and End list
  * - sequential and End list
  */
function nextPlayer()
{
    if (playlist.playbackMode === Playlist.Random) {
        do {
            var temp = player.playlist.currentIndex
            utility.next(player)
        } while (player.playlist.currentIndex  === temp)
    } else if (playlist.playbackMode === Playlist.Loop
               || (shuffleButton.status
                   && (loopButton.status === 2))) {
        utility.next(player)
    } else if ((player.playlist.currentIndex
               !== (playlistModel.rowCount() - 1))
               && !shuffleButton.status && (loopButton.status !== 1)) {
        utility.next(player)
    }
}
