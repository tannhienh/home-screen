#ifndef CLIMATEMODEL_H
#define CLIMATEMODEL_H

#include <QObject>
#include <QDBusConnection>
#include <climate_interface.h>

class ClimateModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int driver_wind_face READ GetDriverWindFace WRITE setDriverWindFace NOTIFY dataChanged)

    Q_PROPERTY(int driver_wind_foot READ GetDriverWindFoot WRITE setDriverWindFoot NOTIFY dataChanged)

    Q_PROPERTY(int driver_temp READ GetDriverTemp WRITE setDriverTemp NOTIFY dataChanged)

    Q_PROPERTY(int fan_level READ GetFanLevel WRITE setFanLevel NOTIFY dataChanged)

    Q_PROPERTY(int passenger_wind_face READ GetPassengerWindFace WRITE setPassengerWindFace NOTIFY dataChanged)

    Q_PROPERTY(int passenger_wind_foot READ GetPassengerWindFoot WRITE setPassengerWindFoot NOTIFY dataChanged)

    Q_PROPERTY(int passenger_temp READ GetPassengerTemp WRITE setPassengerTemp NOTIFY dataChanged)

    Q_PROPERTY(bool auto_mode READ GetAutoMode WRITE setAutoMode NOTIFY dataChanged)

    Q_PROPERTY(bool sync_mode READ GetSyncMode WRITE setSyncMode NOTIFY dataChanged)

    Q_PROPERTY(int outside_temp READ GetOutsideTemp WRITE setOutsideTemp NOTIFY dataChanged)

public:

    explicit ClimateModel(QObject *parent = nullptr);

public slots:

    void setDriverWindFace(int driverWindFace);

    void setDriverWindFoot(int driverWindFoot);

    void setDriverTemp(int driverTemp);

    void setFanLevel(int fanLevel);

    void setPassengerWindFace(int passengerWindFace);

    void setPassengerWindFoot(int passengerWindFoot);

    void setPassengerTemp(int passengerTemp);

    void setAutoMode(bool autoMode);

    void setSyncMode(bool syncMode);

    void setOutsideTemp(int outsideTemp);

private:

    int GetDriverWindFace();

    int GetDriverWindFoot();

    int GetDriverTemp();

    int GetFanLevel();

    int GetPassengerWindFace();

    int GetPassengerWindFoot();

    int GetPassengerTemp();

    bool GetAutoMode();

    bool GetSyncMode();

    int GetOutsideTemp();

    local::Climate *m_climate;

signals:

    void dataChanged();
};

#endif // CLIMATEMODEL_H
