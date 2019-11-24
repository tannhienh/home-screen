#include "climate.h"

Climate::Climate(QObject *parent) : QObject(parent)
{
    // Create instance object DBus
    m_climateAdaptor = new ClimateAdaptor(this);

    // connect to D-Bus and register as an object
    QDBusConnection::sessionBus().registerObject("/Climate", this);
    QDBusConnection::sessionBus().registerService("local.Climate");
}

int Climate::get_driver_wind_face()
{
    return m_driver_wind_face;
}

int Climate::get_driver_wind_foot()
{
    return m_driver_wind_foot;
}

double Climate::get_driver_temp()
{
    return m_driver_temp;
}

int Climate::get_fan_level()
{
    return m_fan_level;
}

int Climate::get_passenger_wind_face()
{
    return m_passenger_wind_face;
}

int Climate::get_passenger_wind_foot()
{
    return m_passenger_wind_foot;
}

double Climate::get_passenger_temp()
{
    return m_passenger_temp;
}

bool Climate::get_auto_mode()
{
    return m_auto_mode;
}

bool Climate::get_sync_mode()
{
    return m_sync_mode;
}

double Climate::get_outside_temp()
{
    return m_outside_temp;
}

void Climate::set_data(int driver_wind_face,
                       int driver_wind_foot,
                       double driver_temp,
                       int fan_level,
                       int passenger_wind_face,
                       int passenger_wind_foot,
                       double passenger_temp,
                       bool auto_mode,
                       bool sync_mode,
                      double outside_temp)
{
    m_driver_wind_face = driver_wind_face;
    m_driver_wind_foot = driver_wind_foot;
    m_driver_temp = driver_temp;
    m_fan_level = fan_level;
    m_passenger_wind_face = passenger_wind_face;
    m_passenger_wind_foot = passenger_wind_foot;
    m_passenger_temp = passenger_temp;
    m_auto_mode = auto_mode;
    m_sync_mode = sync_mode;
    m_outside_temp = outside_temp;

    emit m_climateAdaptor->dataChanged();
}
