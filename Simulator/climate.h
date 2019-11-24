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
    int get_driver_wind_face();

    int get_driver_wind_foot();

    double get_driver_temp();

    int get_fan_level();

    int get_passenger_wind_face();

    int get_passenger_wind_foot();

    double get_passenger_temp();

    bool get_auto_mode();

    bool get_sync_mode();

    double get_outside_temp();

    void set_data(int driver_wind_face,
                  int driver_wind_foot,
                  double driver_temp,
                  int fan_level,
                  int passenger_wind_face,
                  int passenger_wind_foot,
                  double passenger_temp,
                  bool auto_mode,
                  bool sync_mode,
                  double outside_temp);

private:
    int m_driver_wind_face;
    int m_driver_wind_foot;
    double m_driver_temp;
    int m_fan_level;
    int m_passenger_wind_face;
    int m_passenger_wind_foot;
    double m_passenger_temp;
    bool m_auto_mode;
    bool m_sync_mode;
    double m_outside_temp;

    ClimateAdaptor *m_climateAdaptor;

signals:
    void dataChanged();
};

#endif // CLIMATE_H
