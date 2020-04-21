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
    taglib/aifffile.h \
    taglib/aiffproperties.h \
    taglib/apefile.h \
    taglib/apefooter.h \
    taglib/apeitem.h \
    taglib/apeproperties.h \
    taglib/apetag.h \
    taglib/asfattribute.h \
    taglib/asffile.h \
    taglib/asfpicture.h \
    taglib/asfproperties.h \
    taglib/asftag.h \
    taglib/attachedpictureframe.h \
    taglib/audioproperties.h \
    taglib/chapterframe.h \
    taglib/commentsframe.h \
    taglib/eventtimingcodesframe.h \
    taglib/fileref.h \
    taglib/flacfile.h \
    taglib/flacmetadatablock.h \
    taglib/flacpicture.h \
    taglib/flacproperties.h \
    taglib/generalencapsulatedobjectframe.h \
    taglib/id3v1genres.h \
    taglib/id3v1tag.h \
    taglib/id3v2extendedheader.h \
    taglib/id3v2footer.h \
    taglib/id3v2frame.h \
    taglib/id3v2framefactory.h \
    taglib/id3v2header.h \
    taglib/id3v2synchdata.h \
    taglib/id3v2tag.h \
    taglib/infotag.h \
    taglib/itfile.h \
    taglib/itproperties.h \
    taglib/modfile.h \
    taglib/modfilebase.h \
    taglib/modproperties.h \
    taglib/modtag.h \
    taglib/mp4atom.h \
    taglib/mp4coverart.h \
    taglib/mp4file.h \
    taglib/mp4item.h \
    taglib/mp4properties.h \
    taglib/mp4tag.h \
    taglib/mpcfile.h \
    taglib/mpcproperties.h \
    taglib/mpegfile.h \
    taglib/mpegheader.h \
    taglib/mpegproperties.h \
    taglib/oggfile.h \
    taglib/oggflacfile.h \
    taglib/oggpage.h \
    taglib/oggpageheader.h \
    taglib/opusfile.h \
    taglib/opusproperties.h \
    taglib/ownershipframe.h \
    taglib/podcastframe.h \
    taglib/popularimeterframe.h \
    taglib/privateframe.h \
    taglib/relativevolumeframe.h \
    taglib/rifffile.h \
    taglib/s3mfile.h \
    taglib/s3mproperties.h \
    taglib/speexfile.h \
    taglib/speexproperties.h \
    taglib/synchronizedlyricsframe.h \
    taglib/tableofcontentsframe.h \
    taglib/tag.h \
    taglib/tag_c.h \
    taglib/taglib.h \
    taglib/taglib_config.h \
    taglib/taglib_export.h \
    taglib/tbytevector.h \
    taglib/tbytevectorlist.h \
    taglib/tbytevectorstream.h \
    taglib/tdebuglistener.h \
    taglib/textidentificationframe.h \
    taglib/tfile.h \
    taglib/tfilestream.h \
    taglib/tiostream.h \
    taglib/tlist.h \
    taglib/tlist.tcc \
    taglib/tmap.h \
    taglib/tmap.tcc \
    taglib/tpropertymap.h \
    taglib/trefcounter.h \
    taglib/trueaudiofile.h \
    taglib/trueaudioproperties.h \
    taglib/tstring.h \
    taglib/tstringlist.h \
    taglib/uniquefileidentifierframe.h \
    taglib/unknownframe.h \
    taglib/unsynchronizedlyricsframe.h \
    taglib/urllinkframe.h \
    taglib/vorbisfile.h \
    taglib/vorbisproperties.h \
    taglib/wavfile.h \
    taglib/wavpackfile.h \
    taglib/wavpackproperties.h \
    taglib/wavproperties.h \
    taglib/xingheader.h \
    taglib/xiphcomment.h \
    taglib/xmfile.h \
    taglib/xmproperties.h

# Link to zlib for taglib libraries
LIBS += -lz

DISTFILES += \
    Xml/applications.xml \
    taglib/libtag.a

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
