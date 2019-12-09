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
