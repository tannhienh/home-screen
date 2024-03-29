#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Apps/MusicPlayer/cpp/player.h"
#include "Apps/MusicPlayer/cpp/playlistmodel.h"
#include "Cpp/applicationsmodel.h"
#include "Cpp/xmlreader.h"
#include "Cpp/xmlwriter.h"
#include "Cpp/climatemodel.h"
#include "Cpp/weather.h"

// Path Xml file contains applications info
#define XML_APPS_FILE_PATH "../Home_FX00819/Xml/applications.xml"

// API url get weather
#define API_URL "https://api.openweathermap.org/data/2.5/weather"

// App id for api get weather
#define API_APP_ID "3c30b7bd4e796effef3b4bb535b659ac"

int main(int argc, char *argv[])
{
    // Set Qt virtual keyboard for QT_IM_MODULE environment variable
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    /**
     * Set serial port for QT_NMEA_SERIAL_PORT
     * on Linux is ttyS
     * on Windows is COM
     */
//    qputenv("QT_NMEA_SERIAL_PORT", QByteArray("ttyS0"));

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // Set Organization Name and Domain for QSettings
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
    // Climate model
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

    //------------------------------------------------------------------------//
    // Weather API
    Weather weather(API_URL, API_APP_ID);

    engine.rootContext()->setContextProperty("weather", &weather);
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
