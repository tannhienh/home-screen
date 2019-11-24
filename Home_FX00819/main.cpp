#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Apps/MusicPlayer/cpp/player.h"
#include "Apps/MusicPlayer/cpp/playlistmodel.h"
#include "Cpp/applicationsmodel.h"
#include "Cpp/xmlreader.h"
#include "Cpp/climatemodel.h"

#define XML_APPLICATIONS_PATH_FILE "../Home_FX00819/Xml/applications.xml"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //------------------------------------------------------------------------//
    // Applications model
    ApplicationsModel appsModel;

    // XML Reader
    XmlReader xmlReader(XML_APPLICATIONS_PATH_FILE, appsModel);

    engine.rootContext()->setContextProperty("appsModel", &appsModel);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Applications model
    ClimateModel climateModel;
    engine.rootContext()->setContextProperty("climateModel", &climateModel);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Media Player
    Player player;

    qRegisterMetaType<QMediaPlaylist*>("QMediaPlaylist*");

    engine.rootContext()->setContextProperty("playlistModel", player.m_playlistModel);
    engine.rootContext()->setContextProperty("player", player.m_player);
    engine.rootContext()->setContextProperty("playlist", player.m_playlist);
    engine.rootContext()->setContextProperty("utility", &player);
    //------------------------------------------------------------------------//

    const QUrl url(QStringLiteral("qrc:/Qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
