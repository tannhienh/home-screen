#include "climatemodel.h"

ClimateModel::ClimateModel(QObject *parent) : QObject(parent)
{
    m_climate = new local::Climate("local.Climate", "/Climate",
                                   QDBusConnection::sessionBus(), this);

    if (m_climate->isValid()) {
        qDebug() << "Climate DBus connect success";
        QObject::connect(m_climate, &local::Climate::dataChanged,
                         this, &ClimateModel::dataChanged);
    } else {
        qDebug() << "Climate DBus connect error";
    }
}

//----------------------------------------------------------------------------//
// Get Driver wind face
int ClimateModel::GetDriverWindFace()
{
    return m_climate->get_driver_wind_face();
}

// Set Driver wind face
void ClimateModel::setDriverWindFace(int driverWindFace)
{
    m_climate->set_driver_wind_face(driverWindFace);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Driver wind foot
int ClimateModel::GetDriverWindFoot()
{
    return m_climate->get_driver_wind_foot();
}

// Set Driver wind foot
void ClimateModel::setDriverWindFoot(int driverWindFoot)
{
    m_climate->set_driver_wind_foot(driverWindFoot);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Driver temperature
int ClimateModel::GetDriverTemp()
{
    return m_climate->get_driver_temp();
}

// Set Driver teperature
void ClimateModel::setDriverTemp(int driverTemp)
{
    m_climate->set_driver_temp(driverTemp);
    if (GetSyncMode())
        m_climate->set_passenger_temp(driverTemp);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Fan level
int ClimateModel::GetFanLevel()
{
    return m_climate->get_fan_level();
}

// Set Fan level
void ClimateModel::setFanLevel(int fanLevel)
{
    m_climate->set_fan_level(fanLevel);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Passenger wind face
int ClimateModel::GetPassengerWindFace()
{
    return m_climate->get_passenger_wind_face();
}

// Set Passenger wind face
void ClimateModel::setPassengerWindFace(int passengerWindFace)
{
    m_climate->set_passenger_wind_face(passengerWindFace);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Passenger wind foot
int ClimateModel::GetPassengerWindFoot()
{
    return m_climate->get_passenger_wind_foot();
}

// Set Passenger wind foot
void ClimateModel::setPassengerWindFoot(int passengerWindFoot)
{
    m_climate->set_passenger_wind_foot(passengerWindFoot);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Passenger teperature
int ClimateModel::GetPassengerTemp()
{
    return m_climate->get_passenger_temp();
}

// Set Passenger temperature
void ClimateModel::setPassengerTemp(int passengerTemp)
{
    m_climate->set_passenger_temp(passengerTemp);
    if (GetSyncMode())
        m_climate->set_driver_temp(passengerTemp);
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Auto mode
bool ClimateModel::GetAutoMode()
{
    return m_climate->get_auto_mode();
}

// Set Auto mode
void ClimateModel::setAutoMode(bool autoMode)
{
    m_climate->set_auto_mode(autoMode);

}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get Sync mode
bool ClimateModel::GetSyncMode()
{
    return m_climate->get_sync_mode();
}

// Set Sync mode
void ClimateModel::setSyncMode(bool syncMode)
{
    m_climate->set_sync_mode(syncMode);
    if (syncMode) {
        if (GetDriverTemp() > GetPassengerTemp())
            m_climate->set_driver_temp(GetPassengerTemp());
        else
            m_climate->set_passenger_temp(GetDriverTemp());
    }
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Get outside temperature
int ClimateModel::GetOutsideTemp()
{
    return m_climate->get_outside_temp();
}

// Set Outside temperature
void ClimateModel::setOutsideTemp(int outsideTemp)
{
    m_climate->set_outside_temp(outsideTemp);
}
//----------------------------------------------------------------------------//
