#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Apps/MusicPlayer/cpp/player.h"
#include "Apps/MusicPlayer/cpp/playlistmodel.h"
#include "Cpp/applicationsmodel.h"
#include "Cpp/xmlreader.h"
#include "Cpp/xmlwriter.h"
#include "Cpp/climatemodel.h"

#define XML_APPS_FILE_PATH "../Home_FX00819/Xml/applications.xml"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    // Set serial port for QT_NMEA_SERIAL_PORT
    qputenv("QT_NMEA_SERIAL_PORT", QByteArray("ttyS0"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setOrganizationName("Automotive - Funix");
    app.setOrganizationDomain("tannhienh.github.com");

    QQmlApplicationEngine engine;

    //------------------------------------------------------------------------//
    // Applications model
    ApplicationsModel appsModel;

    // XML Reader
    XmlReader xmlReader(XML_APPS_FILE_PATH, &appsModel);
    engine.rootContext()->setContextProperty("xmlReader", &xmlReader);

    // XML Writer
    XmlWriter xmlWriter(XML_APPS_FILE_PATH, &appsModel);
    engine.rootContext()->setContextProperty("xmlWriter", &xmlWriter);

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

    engine.rootContext()->setContextProperty("playlistModel",
                                             player.m_playlistModel);
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
