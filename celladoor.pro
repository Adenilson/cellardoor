include(scripts/scripts.pri)

QT       += core gui network declarative sql

TARGET = cellar

TEMPLATE = app

CONFIG += mobility debug warn_on depend_includepath link_pkgconfig
MOBILITY = organizer systeminfo multimedia

# Add path to Intel AppUp™ SDK headers directory
INCLUDEPATH +=    "$$(IADP_SDK_DIR_MEEGO)Cpp/include"

# Add required libraries
LIBS +=    -lxml2 -lpthread
LIBS +=    "$$(IADP_SDK_DIR_MEEGO)Cpp/lib/libadpruntime.a" \
    "$$(IADP_SDK_DIR_MEEGO)Cpp/lib/libadpcore.a" \
    "$$(IADP_SDK_DIR_MEEGO)Cpp/lib/libxerces-c.a" \
    "$$(IADP_SDK_DIR_MEEGO)Cpp/lib/libxml-security-c.a" \
    "$$(IADP_SDK_DIR_MEEGO)Cpp/lib/libcrypto.a"

# Files to be packed and installed
target.path = /opt/com.cabledogs.cellardoor/

icon.files = Icon/cellardoor.png
icon.path = /usr/share/icons/

icon16.files = Icon/16/cellardoor.png
icon16.path = /usr/share/icons/hicolor/16x16/apps/

icon32.files = Icon/32/cellardoor.png
icon32.path = /usr/share/icons/hicolor/32x32/apps/

icon64.files = Icon/64/cellardoor.png
icon64.path = /usr/share/icons/hicolor/64x64/apps/

icon128.files = Icon/128/cellardoor.png
icon128.path = /usr/share/icons/hicolor/128x128/apps/

desktop.files = cellardoor.desktop
desktop.path = /usr/share/applications

INSTALLS += target icon icon16 icon32 icon64 icon128 desktop

unix:!symbian {
INCLUDEPATH += /usr/include/QtMultimediaKit
#LIBS += -lQtMultimediaKit
}

HEADERS += \
           src/controller.h \
           src/view.h \
           src/utils.h \
           src/wine.h \
           src/genericmodelbase.h \
           src/database.h \
           src/genericmodel.h


SOURCES += \
           src/controller.cpp \
           src/view.cpp \
           src/utils.cpp \
           src/wine.cpp \
           src/genericmodelbase.cpp \
           src/genericmodel.cpp \
           src/database.cpp \
           src/main.cpp

RESOURCES += \
    resources.qrc

INCLUDEPATH += \
               src

TRANSLATIONS = translations/celladoor_pt_BR.ts translations/celladoor_it_IT.ts translations/celladoor_de_DE.ts

symbian: {

    heapSizeRule = \
    "$${LITERAL_HASH}ifdef WINSCW" \
    "EPOCHEAPSIZE  0x14000 0x2000000 // Min 128kB, Max 32MB" \
    "$${LITERAL_HASH}else" \
    "EPOCHEAPSIZE  0x14000 0x8000000 // Min 128kB, Max 128MB" \
    "$${LITERAL_HASH}endif"

    MMP_RULES += heapSizeRule pagedata

    TARGET.CAPABILITY += \
                        NetworkServices \
                        Location \
                        ReadUserData \
                        UserEnvironment \
                        WriteUserData

    LIBS += \
        -lavkon \
        -leikcore \
        -lcone

    ICON = icon.svg

    addFiles.sources = translations/celladoor_pt_BR.qm translations/celladoor_it_IT.qm
    addFiles.path = .
    DEPLOYMENT += addFiles
}

i18n.files = $${SOURCE_TREE}/celladoor_pt_BR.qm $${SOURCE_TREE}/celladoor_it_IT.qm
i18n.path = $${PREFIX}/share/$${TARGET}/i18n
INSTALLS += i18n

deb.commands = dpkg-buildpackage -rfakeroot -uc -us -sa -I.git $(DEB_EXTRA_OPTIONS)
QMAKE_EXTRA_TARGETS += deb
