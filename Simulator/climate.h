#ifndef CLIMATE_H
#define CLIMATE_H

#include <QObject>
#include <QDBusConnection>
#include <climate_adaptor.h>

class Climate : public QObject
{
    Q_OBJECT

public:
    explicit Climate(QObject *parent = nullptr);

public slots:

    //------------------------------------------------------------------------//
    // Get Driver wind face
    int get_driver_wind_face();

    // Set Driver wind face
    void set_driver_wind_face(int driver_wind_face);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Driver wind foot
    int get_driver_wind_foot();

    // Set Driver wind foot
    void set_driver_wind_foot(int driver_wind_foot);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Driver temperature
    int get_driver_temp();

    // Set Driver teperature
    void set_driver_temp(int driver_temp);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Fan level
    int get_fan_level();

    // Set Fan level
    void set_fan_level(int fan_level);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Passenger wind face
    int get_passenger_wind_face();

    void set_passenger_wind_face(int passenger_wind_face);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Passenger wind foot
    int get_passenger_wind_foot();

    void set_passenger_wind_foot(int passenger_wind_foot);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Passenger temperature
    int get_passenger_temp();

    void set_passenger_temp(int passenger_temp);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Auto mode
    bool get_auto_mode();

    void set_auto_mode(bool auto_mode);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Sync mode
    bool get_sync_mode();

    void set_sync_mode(bool sync_mode);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Outside temperature
    int get_outside_temp();

    void set_outside_temp(int outside_temp);
    //------------------------------------------------------------------------//

private:
    int m_driver_wind_face;
    int m_driver_wind_foot;
    int m_driver_temp;
    int m_fan_level;
    int m_passenger_wind_face;
    int m_passenger_wind_foot;
    int m_passenger_temp;
    bool m_auto_mode;
    bool m_sync_mode;
    int m_outside_temp;

    ClimateAdaptor *m_climateAdaptor;

signals:
    void dataChanged();
};

#endif // CLIMATE_H
