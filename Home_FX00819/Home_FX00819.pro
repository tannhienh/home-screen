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
    Cpp/xmlwriter.h \
    taglib/attachedpictureframe.h \
    taglib/audioproperties.h \
    taglib/fileref.h \
    taglib/id3v2frame.h \
    taglib/id3v2framefactory.h \
    taglib/id3v2header.h \
    taglib/id3v2tag.h \
    taglib/mpegfile.h \
    taglib/mpegheader.h \
    taglib/mpegproperties.h \
    taglib/tag.h \
    taglib/taglib.h \
    taglib/taglib_config.h \
    taglib/taglib_export.h \
    taglib/tbytevector.h \
    taglib/tbytevectorlist.h \
    taglib/tfile.h \
    taglib/tiostream.h \
    taglib/tlist.h \
    taglib/tlist.tcc \
    taglib/tmap.h \
    taglib/tmap.tcc \
    taglib/trefcounter.h \
    taglib/tstring.h \
    taglib/tstringlist.h

# Linking to zlib for taglib libraries
LIBS += -lz

DISTFILES += \
    Xml/applications.xml \
    taglib/libtag.a

#------------------------------------------------------------------------------#
# static Taglib library support play media
#
win32:CONFIG(release, debug|release): LIBS += -L$$PWD/taglib/release/ -ltag
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/taglib/debug/ -ltag
else:unix: LIBS += -L$$PWD/taglib/ -ltag

INCLUDEPATH += $$PWD/taglib
DEPENDPATH += $$PWD/taglib

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/taglib/release/libtag.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/taglib/debug/libtag.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/taglib/release/tag.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/taglib/debug/tag.lib
else:unix: PRE_TARGETDEPS += $$PWD/taglib/libtag.a
#------------------------------------------------------------------------------#
