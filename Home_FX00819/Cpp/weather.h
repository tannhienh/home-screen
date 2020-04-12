#ifndef WEATHER_H
#define WEATHER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>

class Weather : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double temp READ getTemp NOTIFY tempChanged)

public:
    explicit Weather(QString url, QString appid);

public slots:
    void get(double latitude, double longitude);

private slots:
    double getTemp();
    void readyRead();

private:
    QNetworkAccessManager manager;
    QJsonDocument jsonDocument;
    QString m_url;
    QString m_appid;
    double m_temp;

signals:
    void tempChanged();
};

#endif // WEATHER_H
