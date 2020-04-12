#include "weather.h"

// Constructor Weather class
Weather::Weather(QString url, QString appid)
{
    m_url = url;
    m_appid = appid;
}

// Get method implement
void Weather::get(double latitude, double longitude)
{
    // Create url with parameters latitude, longitude and appid
    QString url = m_url;
    url.append("?lat=" + QString::number(latitude));
    url.append("&lon=" + QString::number(longitude));
    url.append("&appid=" + m_appid);

    QNetworkRequest request;
    request.setUrl(QUrl(url));
    QNetworkReply *reply = manager.get(request);
    connect(reply, &QNetworkReply::readyRead, this, &Weather::readyRead);
}

double Weather::getTemp()
{
    return m_temp;
}

/**
 *  Weather::readyRead
 *
 * Json API response sample:
 *
 * {
 *   "coord": {
 *       "lon": 106.7,
 *       "lat": 10.78
 *   },
 *   "weather": [
 *       {
 *           "id": 802,
 *           "main": "Clouds",
 *           "description": "scattered clouds",
 *           "icon": "03d"
 *       }
 *   ],
 *   "base": "stations",
 *   "main": {
 *       "temp": 305.15,
 *       "feels_like": 307.97,
 *       "temp_min": 305.15,
 *       "temp_max": 305.15,
 *       "pressure": 1013,
 *       "humidity": 62
 *   },
 *   "visibility": 10000,
 *   "wind": {
 *       "speed": 4.1,
 *       "deg": 110
 *   },
 *   "clouds": {
 *       "all": 40
 *   },
 *   "dt": 1586489931,
 *   "sys": {
 *       "type": 1,
 *       "id": 9314,
 *       "country": "VN",
 *       "sunrise": 1586472283,
 *       "sunset": 1586516629
 *   },
 *   "timezone": 25200,
 *   "id": 1566083,
 *   "name": "Ho Chi Minh City",
 *   "cod": 200
 * }
 */

void Weather::readyRead()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());

    QJsonParseError jsonError;

    jsonDocument = QJsonDocument::fromJson(reply->readAll(), &jsonError);

    if (jsonError.error != QJsonParseError::NoError) {
        qInfo() << "The Json Parse Error: " << jsonError.errorString();
    } else  {
        QJsonObject rootObject = jsonDocument.object();

        if (rootObject.contains("main") && rootObject["main"].isObject()) {
            QJsonObject mainObject = rootObject["main"].toObject();
            if (mainObject.contains("temp") && mainObject["temp"].isDouble()) {
                m_temp = mainObject["temp"].toDouble();
                emit tempChanged();
            } else
                qDebug() << "Has no \"temp\" object in \"main\" object json response";
        } else
            qDebug() << "Has no \"main\" object in json response";
    }

    reply->deleteLater();
}
