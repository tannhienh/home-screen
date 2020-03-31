#ifndef CLIMATEMODEL_H
#define CLIMATEMODEL_H

#include <QObject>
#include <QDBusConnection>
#include <climate_interface.h>

class ClimateModel : public QObject
{
    Q_OBJECT

    // Air mode on face of driver
    Q_PROPERTY(int driver_wind_face READ GetDriverWindFace WRITE setDriverWindFace NOTIFY dataChanged)

    // Air mode on foot of driver
    Q_PROPERTY(int driver_wind_foot READ GetDriverWindFoot WRITE setDriverWindFoot NOTIFY dataChanged)

    // Temperature of driver
    Q_PROPERTY(int driver_temp READ GetDriverTemp WRITE setDriverTemp NOTIFY dataChanged)

    // Fan level of climate
    Q_PROPERTY(int fan_level READ GetFanLevel WRITE setFanLevel NOTIFY dataChanged)

    // Air mode on face of passenger
    Q_PROPERTY(int passenger_wind_face READ GetPassengerWindFace WRITE setPassengerWindFace NOTIFY dataChanged)

    // Air mode on foot of passenger
    Q_PROPERTY(int passenger_wind_foot READ GetPassengerWindFoot WRITE setPassengerWindFoot NOTIFY dataChanged)

    // Temperature of passsenger
    Q_PROPERTY(int passenger_temp READ GetPassengerTemp WRITE setPassengerTemp NOTIFY dataChanged)

    // Auto mode of climate
    Q_PROPERTY(bool auto_mode READ GetAutoMode WRITE setAutoMode NOTIFY dataChanged)

    // Sync mode of climate
    Q_PROPERTY(bool sync_mode READ GetSyncMode WRITE setSyncMode NOTIFY dataChanged)

    // Outside temperature
    Q_PROPERTY(int outside_temp READ GetOutsideTemp WRITE setOutsideTemp NOTIFY dataChanged)

    // Driver heated seat
    Q_PROPERTY(int driver_heated_seat READ GetDriverHeatedSeat WRITE setDriverHeatedSeat NOTIFY dataChanged)

    // Head Defog
    Q_PROPERTY(int head_defog READ GetHeadDefog WRITE setHeadDefog NOTIFY dataChanged)

    // Air in car
    Q_PROPERTY(int air_in_car READ GetAirInCar WRITE setAirInCar NOTIFY dataChanged)

    // Rear defog
    Q_PROPERTY(int rear_defog READ GetRearDefog WRITE setRearDefog NOTIFY dataChanged)

    // Passenger heated seat
    Q_PROPERTY(int passenger_heated_seat READ GetPassengerHeatedSeat WRITE setPassengerHeatedSeat NOTIFY dataChanged)

public:

    // Constructor
    explicit ClimateModel(QObject *parent = nullptr);

public slots:

    // Set air mode on face of driver
    void setDriverWindFace(int driverWindFace);

    // Set air mode on foot of driver
    void setDriverWindFoot(int driverWindFoot);

    // Set Driver teperature
    void setDriverTemp(int driverTemp);

    // Set fan level of climate
    void setFanLevel(int fanLevel);

    // Set air mode on face of passenger
    void setPassengerWindFace(int passengerWindFace);

    // Set air mode on foot of passenger
    void setPassengerWindFoot(int passengerWindFoot);

    // Set Passenger temperature
    void setPassengerTemp(int passengerTemp);

    // Set auto mmode of climate
    void setAutoMode(bool autoMode);

    // Set Sync mode of climate
    void setSyncMode(bool syncMode);

    // Set outside temperature
    void setOutsideTemp(int outsideTemp);

    // Set Driver heated seat
    void setDriverHeatedSeat(int driverHeatedSeat);

    // Set Head defog
    void setHeadDefog(int headDefog);

    // Set Air in car
    void setAirInCar(int airInCar);

    // Set Rear defog
    void setRearDefog(int rearDefog);

    // Set Passenger heated seat
    void setPassengerHeatedSeat(int passengerHeatedSeat);

private:

    // Get air mode on face of driver
    int GetDriverWindFace();

    // Get air mode on foot of driver
    int GetDriverWindFoot();

    // Get Driver temperature
    int GetDriverTemp();

    // Get fan level of climate
    int GetFanLevel();

    // Get air mode on face of passenger
    int GetPassengerWindFace();

    // Get air mode on foot of passenger
    int GetPassengerWindFoot();

    // Get Passenger teperature
    int GetPassengerTemp();

    // Get auto mode of climate
    bool GetAutoMode();

    // Get sync mode of climate
    bool GetSyncMode();

    // Get outside temperature
    int GetOutsideTemp();

    // Get Driver heated seat
    int GetDriverHeatedSeat();

    // Get Head defog
    int GetHeadDefog();

    // Get Air in car
    int GetAirInCar();

    // Get Rear Defog()
    int GetRearDefog();

    // Get Passenger heated seat
    int GetPassengerHeatedSeat();

    local::Climate *m_climate;

signals:

    // Common signal when data changed
    void dataChanged();
};

#endif // CLIMATEMODEL_H
