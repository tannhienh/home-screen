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
    // Get Passenger wind face
    int get_passenger_wind_face();

    // Set Passenger wind face
    void set_passenger_wind_face(int passenger_wind_face);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Passenger wind foot
    int get_passenger_wind_foot();

    // Set Passenger wind foot
    void set_passenger_wind_foot(int passenger_wind_foot);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Passenger temperature
    int get_passenger_temp();

    // Set Passenger temperature
    void set_passenger_temp(int passenger_temp);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Auto mode
    bool get_auto_mode();

    // Set Auto mode
    void set_auto_mode(bool auto_mode);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Sync mode
    bool get_sync_mode();

    // Set Sync mode
    void set_sync_mode(bool sync_mode);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Heated seat driver
    int get_driver_heated_seat();

    // Set Heated seat driver
    void set_driver_heated_seat(int driver_heated_seat);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get Head defog
    int get_head_defog();

    // Set Head defog
    void set_head_defog(int head_defog);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get AC mode
    bool get_ac_mode();

    // Set Head defog
    void set_ac_mode(bool ac_mode);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get air in car
    int get_air_in_car();

    // Set air in car
    void set_air_in_car(int air_in_car);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get rear defog
    int get_rear_defog();

    // Set rear defog
    void set_rear_defog(int rear_defog);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get heated seat passenger
    int get_passenger_heated_seat();

    // Set heated seat passenger
    void set_passenger_heated_seat(int passenger_heated_seat);
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Get temperature unit
    bool get_temp_unit();

    // Set temperature unit
    void set_temp_unit(bool temp_unit);
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
    int m_driver_heated_seat;
    int m_head_defog;
    bool m_ac_mode;
    int m_air_in_car;
    int m_rear_defog;
    int m_passenger_heated_seat;
    bool m_temp_unit;

    ClimateAdaptor *m_climateAdaptor;

signals:
    void dataChanged();
    void tempUnitChangedToF();
    void tempUnitChangedToC();
};

#endif // CLIMATE_H
