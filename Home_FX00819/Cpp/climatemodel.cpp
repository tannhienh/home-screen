#include "climatemodel.h"

// Constructor for ClimateModel
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
// Set air mode on face of driver
void ClimateModel::setDriverWindFace(int driverWindFace)
{
    m_climate->set_driver_wind_face(driverWindFace);
}

// Get air mode on face of driver
int ClimateModel::GetDriverWindFace()
{
    return m_climate->get_driver_wind_face();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set air mode on foot of driver
void ClimateModel::setDriverWindFoot(int driverWindFoot)
{
    m_climate->set_driver_wind_foot(driverWindFoot);
}

// Get air mode on foot of driver
int ClimateModel::GetDriverWindFoot()
{
    return m_climate->get_driver_wind_foot();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Driver teperature
void ClimateModel::setDriverTemp(int driverTemp)
{
    m_climate->set_driver_temp(driverTemp);
    if (GetSyncMode())
        m_climate->set_passenger_temp(driverTemp);
}

// Get Driver temperature
int ClimateModel::GetDriverTemp()
{
    return m_climate->get_driver_temp();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set fan level of climate
void ClimateModel::setFanLevel(int fanLevel)
{
    m_climate->set_fan_level(fanLevel);
}

// Get fan level of climate
int ClimateModel::GetFanLevel()
{
    return m_climate->get_fan_level();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set air mode on face of passenger
void ClimateModel::setPassengerWindFace(int passengerWindFace)
{
    m_climate->set_passenger_wind_face(passengerWindFace);
}

// Get air mode on face of passenger
int ClimateModel::GetPassengerWindFace()
{
    return m_climate->get_passenger_wind_face();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set air mode on foot of passenger
void ClimateModel::setPassengerWindFoot(int passengerWindFoot)
{
    m_climate->set_passenger_wind_foot(passengerWindFoot);
}

// Get air mode on foot of passenger
int ClimateModel::GetPassengerWindFoot()
{
    return m_climate->get_passenger_wind_foot();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Passenger temperature
void ClimateModel::setPassengerTemp(int passengerTemp)
{
    m_climate->set_passenger_temp(passengerTemp);
    if (GetSyncMode())
        m_climate->set_driver_temp(passengerTemp);
}

// Get Passenger teperature
int ClimateModel::GetPassengerTemp()
{
    return m_climate->get_passenger_temp();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Auto mode of climate
void ClimateModel::setAutoMode(bool autoMode)
{
    m_climate->set_auto_mode(autoMode);
}

// Get Auto mode of climate
bool ClimateModel::GetAutoMode()
{
    return m_climate->get_auto_mode();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Sync mode of climate
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

// Get Sync mode of climate
bool ClimateModel::GetSyncMode()
{
    return m_climate->get_sync_mode();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Outside temperature
void ClimateModel::setOutsideTemp(int outsideTemp)
{
    m_climate->set_outside_temp(outsideTemp);
}

// Get outside temperature
int ClimateModel::GetOutsideTemp()
{
    return m_climate->get_outside_temp();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Driver heated seat
void ClimateModel::setDriverHeatedSeat(int driverHeatedSeat)
{
    m_climate->set_driver_heated_seat(driverHeatedSeat);
}

// Get Driver heated seat
int ClimateModel::GetDriverHeatedSeat()
{
    return m_climate->get_driver_heated_seat();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Head defog
void ClimateModel::setHeadDefog(int headDefog)
{
    m_climate->set_head_defog(headDefog);
}

// Get Head defog
int ClimateModel::GetHeadDefog()
{
    return m_climate->get_head_defog();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Air in car
void ClimateModel::setAirInCar(int airInCar)
{
    m_climate->set_air_in_car(airInCar);
}

// Get Air in car
int ClimateModel::GetAirInCar()
{
    return m_climate->get_air_in_car();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Rear defog
void ClimateModel::setRearDefog(int rearDefog)
{
    m_climate->set_rear_defog(rearDefog);
}

// Get Rear defog
int ClimateModel::GetRearDefog()
{
    return m_climate->get_rear_defog();
}
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// Set Passenger heated seat
void ClimateModel::setPassengerHeatedSeat(int passengerHeatedSeat)
{
    m_climate->set_passenger_heated_seat(passengerHeatedSeat);
}

// Get Passenger heated seat
int ClimateModel::GetPassengerHeatedSeat()
{
    return m_climate->get_passenger_heated_seat();
}
//----------------------------------------------------------------------------//
