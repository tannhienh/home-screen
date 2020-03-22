#include <QMediaService>
#include <QMediaPlaylist>
#include <QMediaMetaData>
#include <QObject>
#include <QFileInfo>
#include <QTime>
#include <QDir>
#include <QStandardPaths>

#include "Apps/MusicPlayer/cpp/player.h"
#include "Apps/MusicPlayer/cpp/playlistmodel.h"

// Constructor Player function
Player::Player(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer(this);          // Create Media Player
    m_playlist = new QMediaPlaylist(this);      // Create Media Playlist
    m_player->setPlaylist(m_playlist);          // Set playlist for media player
    m_playlistModel = new PlaylistModel(this);  // Create playlist model
    open();     // Load audios

    // If playlist not empty, set current index is first audio
    if (!m_playlist->isEmpty())
        m_playlist->setCurrentIndex(0);
}

// add list of audios to playlist model
void Player::addToPlaylist(const QList<QUrl> &urls)
{
    for (auto &url: urls) {

        m_playlist->addMedia(url);

        FileRef f(url.path().toStdString().c_str());
        Tag *tag = f.tag();
        Song song(QString::fromWCharArray(tag->title().toCWString()),
                  QString::fromWCharArray(tag->artist().toCWString()),
                  url.toDisplayString(),
                  getAlbumArt(url));

        m_playlistModel->addSong(song);
    }
}

// Load audios from default location of Music directory which are mp3 file
// get path for add to playlist
void Player::open()
{
    QDir directory(QStandardPaths::standardLocations
                   (QStandardPaths::MusicLocation)[0]);

    QFileInfoList musics = directory.entryInfoList(QStringList() << "*.mp3",
                                                   QDir::Files);
    QList<QUrl> urls;

    for (int i = 0; i < musics.length(); i++){
        urls.append(QUrl::fromLocalFile(musics[i].absoluteFilePath()));
    }

    addToPlaylist(urls);    // Add list audios to playlist
}

// Get current time and total time
QString Player::getTimeInfo(qint64 timeInput)
{
    timeInput /= 1000;
    QTime time((timeInput / 3600) % 60, (timeInput / 60) % 60,
               timeInput % 60, (timeInput * 1000) % 1000);
    QString format = "mm:ss";
    if (timeInput > 3600)
        format = "hh:mm:ss";
    QString timeFormated = time.toString(format);

    return timeFormated;
}

// Previous song in playlist
void Player::previous(QMediaPlayer *player)
{
    if (player->playlist()->playbackMode() == QMediaPlaylist::CurrentItemInLoop)
    {
        player->playlist()->setPlaybackMode(QMediaPlaylist::Sequential);
        player->playlist()->previous();
        player->playlist()->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
    else
        player->playlist()->previous();
}

// Play media process
void Player::play(QMediaPlayer *player)
{
    player->play();
}

// Pause media process
void Player::pause(QMediaPlayer *player)
{
    player->pause();
}

// Next song in playlist
void Player::next(QMediaPlayer *player)
{
    if (player->playlist()->playbackMode() == QMediaPlaylist::CurrentItemInLoop)
    {
        player->playlist()->setPlaybackMode(QMediaPlaylist::Sequential);
        player->playlist()->next();
        player->playlist()->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    } else
        player->playlist()->next();
}

/*
 *
 * Shuffle mode
 *
 * Shuffle button +  loop button:        player mode
 *
 * Shuffle on    +   loop off (0):       random
 * Shuffle on    +   loop playlist (1):  random
 * Shuffle on    +   loop current (2):   loop current
 * Shuffle off   +   loop off (0):       sequential
 * Shuffle off   +   loop playlist (1):  loop
 * Shuffle off   +   loop current (2):   loop current
 */
void Player::setPlayerMode(QMediaPlayer *player, bool shuffle_status,
                           int loop_status)
{
    if (shuffle_status) {
        if (loop_status == 2)
            player->playlist()->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
        else
            player->playlist()->setPlaybackMode(QMediaPlaylist::Random);
    }
    else {
        if (loop_status == 0)
            player->playlist()->setPlaybackMode(QMediaPlaylist::Sequential);
        if (loop_status == 1) {
            player->playlist()->setPlaybackMode(QMediaPlaylist::Loop);
        }
        if (loop_status == 2)
            player->playlist()->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
}

// Get album art from audio file
QString Player::getAlbumArt(QUrl url)
{
    static const char *IdPicture = "APIC" ;
    MPEG::File mpegFile(url.path().toStdString().c_str());
    ID3v2::Tag *id3v2tag = mpegFile.ID3v2Tag();
    ID3v2::FrameList Frame ;
    ID3v2::AttachedPictureFrame *PicFrame ;
    void *SrcImage ;
    unsigned long Size ;

    FILE *jpegFile;
    jpegFile = fopen(QString(url.fileName()+".jpg").toStdString().c_str(),"wb");

    if (id3v2tag)
    {
        // picture frame
        Frame = id3v2tag->frameListMap()[IdPicture] ;
        if (!Frame.isEmpty())
        {
            for(ID3v2::FrameList::ConstIterator it = Frame.begin();
                it != Frame.end(); ++it)
            {
                PicFrame = static_cast<ID3v2::AttachedPictureFrame*>(*it) ;
                {
                    Size = PicFrame->picture().size() ;
                    SrcImage = malloc ( Size ) ;
                    if (SrcImage)
                    {
                        memcpy (SrcImage, PicFrame->picture().data(), Size ) ;
                        fwrite(SrcImage,Size,1, jpegFile);
                        fclose(jpegFile);
                        free( SrcImage ) ;
                        return QUrl::fromLocalFile(url.fileName()+".jpg").\
                                     toDisplayString();
                    }
                }
            }
        }
    }
    else
        return "qrc:/Apps/MusicPlayer/images/default_cover_art.jpg";

    return "qrc:/Apps/MusicPlayer/images/default_cover_art.jpg";
}
