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

int ClimateModel::GetDriverWindFace()
{
    return m_climate->get_driver_wind_face();
}

int ClimateModel::GetDriverWindFoot()
{
    return m_climate->get_driver_wind_foot();
}

double ClimateModel::GetDriverTemp()
{
    return m_climate->get_driver_temp();
}

int ClimateModel::GetFanLevel()
{
    return m_climate->get_fan_level();
}

int ClimateModel::GetPassengerWindFace()
{
    return m_climate->get_passenger_wind_face();
}

int ClimateModel::GetPassengerWindFoot()
{
    return m_climate->get_passenger_wind_foot();
}

double ClimateModel::GetPpassengerTemp()
{
    return m_climate->get_passenger_temp();
}

bool ClimateModel::GetAutoMode()
{
    return m_climate->get_auto_mode();
}

bool ClimateModel::GetSyncMode()
{
    return m_climate->get_sync_mode();
}

double ClimateModel::GetOutsideTemp()
{
    return m_climate->get_outside_temp();
}
