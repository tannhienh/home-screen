QT += quick core multimedia xml dbus

CONFIG += c++11

DBUS_INTERFACES += DBus/climate.xml

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        Apps/MusicPlayer/cpp/player.cpp \
        Apps/MusicPlayer/cpp/playlistmodel.cpp \
        Cpp/applicationitem.cpp \
        Cpp/applicationsmodel.cpp \
        Cpp/climatemodel.cpp \
        Cpp/weather.cpp \
        Cpp/xmlreader.cpp \
        Cpp/xmlwriter.cpp \
        main.cpp

RESOURCES += \
    js.qrc \
    fonts.qrc \
    images.qrc \
    qml.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Apps/MusicPlayer/cpp/player.h \
    Apps/MusicPlayer/cpp/playlistmodel.h \
    Cpp/applicationitem.h \
    Cpp/applicationsmodel.h \
    Cpp/climatemodel.h \
    Cpp/weather.h \
    Cpp/xmlreader.h \ \
    Cpp/xmlwriter.h

# link taglib libraries
LIBS += -ltag

DISTFILES += \
    Xml/applications.xml
