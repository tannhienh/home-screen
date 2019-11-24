#ifndef CLIMATEMODEL_H
#define CLIMATEMODEL_H

#include <QObject>
#include <QDBusConnection>
#include <climate_interface.h>

class ClimateModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int driver_wind_face READ GetDriverWindFace NOTIFY dataChanged)

    Q_PROPERTY(int driver_wind_foot READ GetDriverWindFoot NOTIFY dataChanged)

    Q_PROPERTY(double driver_temp READ GetDriverTemp NOTIFY dataChanged)

    Q_PROPERTY(int fan_level READ GetFanLevel NOTIFY dataChanged)

    Q_PROPERTY(int passenger_wind_face READ GetPassengerWindFace NOTIFY dataChanged)

    Q_PROPERTY(int passenger_wind_foot READ GetPassengerWindFoot NOTIFY dataChanged)

    Q_PROPERTY(double passenger_temp READ GetPpassengerTemp NOTIFY dataChanged)

    Q_PROPERTY(bool auto_mode READ GetAutoMode NOTIFY dataChanged)

    Q_PROPERTY(bool sync_mode READ GetSyncMode NOTIFY dataChanged)

    Q_PROPERTY(double outside_temp READ GetOutsideTemp NOTIFY dataChanged)

public:
    explicit ClimateModel(QObject *parent = nullptr);

private:
    int GetDriverWindFace();

    int GetDriverWindFoot();

    double GetDriverTemp();

    int GetFanLevel();

    int GetPassengerWindFace();

    int GetPassengerWindFoot();

    double GetPpassengerTemp();

    bool GetAutoMode();

    bool GetSyncMode();

    double GetOutsideTemp();

    local::Climate *m_climate;

signals:
    void dataChanged();
};

#endif // CLIMATEMODEL_H
