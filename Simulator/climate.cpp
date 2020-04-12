#include "climate.h"

Climate::Climate(QObject *parent) : QObject(parent)
{
//     Create instance object DBus
    m_climateAdaptor = new ClimateAdaptor(this);

//     connect to D-Bus and register as an object
    QDBusConnection::sessionBus().registerObject("/Climate", this);
    QDBusConnection::sessionBus().registerService("local.Climate");

    m_temp_unit = false;
    m_driver_wind_face = 0;
    m_driver_wind_foot = 0;
    m_driver_temp = m_temp_unit ? 77 : 25;
    m_fan_level = 4;
    m_passenger_wind_face = 0;
    m_passenger_wind_foot = 0;
    m_passenger_temp = m_temp_unit ? 77 : 25;
    m_auto_mode = false;
    m_sync_mode = false;
    m_driver_heated_seat = 0;
    m_head_defog = 0;
    m_ac_mode = false;
    m_air_in_car = 0;
    m_rear_defog = 0;
    m_passenger_heated_seat = 0;
    qDebug() << "Completed constructor" << endl;
    qDebug() << "m_temp_unit: " << m_temp_unit << endl;
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
// Get Heated seat driver
int Climate::get_driver_heated_seat()
{
    return m_driver_heated_seat;
}

// Set Heated seat driver
void Climate::set_driver_heated_seat(int driver_heated_seat)
{
    if (driver_heated_seat != m_driver_heated_seat) {
        m_driver_heated_seat = driver_heated_seat;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Head defog
int Climate::get_head_defog()
{
    return m_head_defog;
}

// Set Head defog
void Climate::set_head_defog(int head_defog)
{
    if (head_defog != m_head_defog) {
        m_head_defog = head_defog;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get AC mode
bool Climate::get_ac_mode()
{
    return m_ac_mode;
}

// Set Auto mode
void Climate::set_ac_mode(bool ac_mode)
{
    if (ac_mode != m_ac_mode) {
        m_ac_mode = ac_mode;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get air in car
int Climate::get_air_in_car()
{
    return m_air_in_car;
}

// Set air in car
void Climate::set_air_in_car(int air_in_car)
{
    if (air_in_car != m_air_in_car) {
        m_air_in_car = air_in_car;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get rear defog
int Climate::get_rear_defog()
{
    return m_rear_defog;
}

// Set rear defog
void Climate::set_rear_defog(int rear_defog)
{
    if (rear_defog != m_rear_defog) {
        m_rear_defog = rear_defog;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get heated seat passenger
int Climate::get_passenger_heated_seat()
{
    return m_passenger_heated_seat;
}

// Set heated seat passenger
void Climate::set_passenger_heated_seat(int passenger_heated_seat)
{
    if (passenger_heated_seat != m_passenger_heated_seat) {
        m_passenger_heated_seat = passenger_heated_seat;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get temperature unit
bool Climate::get_temp_unit()
{
    return m_temp_unit;
}

// Set temperature unit
void Climate::set_temp_unit(bool temp_unit)
{
    if (temp_unit != m_temp_unit) {
        m_temp_unit = temp_unit;
        qDebug() << endl << "Before m_driver_temp: " << m_driver_temp;
        if (temp_unit) {
            m_driver_temp = lround(m_driver_temp * 1.8 + 32);
            m_passenger_temp = lround(m_passenger_temp * 1.8 + 32);
            qDebug() << "Unit F" << endl;
            emit tempUnitChangedToF();
        }
        else {
            m_driver_temp = lround((m_driver_temp - 32) / 1.8);
            m_passenger_temp = lround((m_passenger_temp - 32) / 1.8);
            qDebug() << "Unit C" << endl;
            emit tempUnitChangedToC();
        }

        qDebug() << "After m_driver_temp: " << m_driver_temp;

        qDebug() << "After m_temp_unit: " << m_temp_unit << endl;
        emit dataChanged();
    }
}
//----------------------------------------------------------------------------//
