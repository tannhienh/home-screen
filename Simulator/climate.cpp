#include "climate.h"

Climate::Climate(QObject *parent) : QObject(parent)
{
    // Create instance object DBus
    m_climateAdaptor = new ClimateAdaptor(this);

    // connect to D-Bus and register as an object
    QDBusConnection::sessionBus().registerObject("/Climate", this);
    QDBusConnection::sessionBus().registerService("local.Climate");

    m_driver_wind_face = 0;
    m_driver_wind_foot = 0;
    m_driver_temp = 25;
    m_fan_level = 4;
    m_passenger_wind_face = 0;
    m_passenger_wind_foot = 0;
    m_passenger_temp = 25;
    m_auto_mode = false;
    m_sync_mode = false;
    m_outside_temp = 27;
}

//----------------------------------------------------------------------------//
// Get Driver wind face
int Climate::get_driver_wind_face()
{
    return m_driver_wind_face;
}

// Set Driver wind face
void Climate::set_driver_wind_face(int driver_wind_face)
{
    if (driver_wind_face != m_driver_wind_face) {
        m_driver_wind_face = driver_wind_face;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Driver wind foot
int Climate::get_driver_wind_foot()
{
    return m_driver_wind_foot;
}

// Set Driver wind foot
void Climate::set_driver_wind_foot(int driver_wind_foot)
{
    if (driver_wind_foot != m_driver_wind_foot) {
        m_driver_wind_foot = driver_wind_foot;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Driver temperature
int Climate::get_driver_temp()
{
    return m_driver_temp;
}

// Set Driver teperature
void Climate::set_driver_temp(int driver_temp)
{
    if (driver_temp != m_driver_temp) {
        m_driver_temp = driver_temp;
        if (m_sync_mode)
            m_passenger_temp = driver_temp;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Fan level
int Climate::get_fan_level()
{
    return m_fan_level;
}

// Set Fan level
void Climate::set_fan_level(int fan_level)
{
    if (fan_level != m_fan_level) {
        m_fan_level = fan_level;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Passenger wind face
int Climate::get_passenger_wind_face()
{
    return m_passenger_wind_face;
}

// Set Passenger wind face
void Climate::set_passenger_wind_face(int passenger_wind_face)
{
    if (passenger_wind_face != m_passenger_wind_face) {
        m_passenger_wind_face = passenger_wind_face;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Passenger wind foot
int Climate::get_passenger_wind_foot()
{
    return m_passenger_wind_foot;
}

// Set Passenger wind foot
void Climate::set_passenger_wind_foot(int passenger_wind_foot)
{
    if (passenger_wind_foot != m_passenger_wind_foot) {
        m_passenger_wind_foot = passenger_wind_foot;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Passenger teperature
int Climate::get_passenger_temp()
{
    return m_passenger_temp;
}

// Set Passenger temperature
void Climate::set_passenger_temp(int passenger_temp)
{
    if (passenger_temp != m_passenger_temp) {
        m_passenger_temp = passenger_temp;
        if (m_sync_mode)
            m_driver_temp = passenger_temp;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Auto mode
bool Climate::get_auto_mode()
{
    return m_auto_mode;
}

// Set Auto mode
void Climate::set_auto_mode(bool auto_mode)
{
    if (auto_mode != m_auto_mode) {
        m_auto_mode = auto_mode;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Sync mode
bool Climate::get_sync_mode()
{
    return m_sync_mode;
}

// Set Sync mode
void Climate::set_sync_mode(bool sync_mode)
{
    if (sync_mode != m_sync_mode) {
        m_sync_mode = sync_mode;

        if (m_driver_temp > m_passenger_temp)
            m_driver_temp = m_passenger_temp;
        else
            m_passenger_temp = m_driver_temp;

        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get outside temperature
int Climate::get_outside_temp()
{
    return m_outside_temp;
}

// Set Outside temperature
void Climate::set_outside_temp(int outside_temp)
{
    if (outside_temp != m_outside_temp) {
        m_outside_temp = outside_temp;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//
