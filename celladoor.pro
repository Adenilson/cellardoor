include(scripts/scripts.pri)

QT       += core gui network declarative sql

TARGET = cellar

TEMPLATE = app

CONFIG += mobility debug warn_on depend_includepath link_pkgconfig
MOBILITY = organizer systeminfo multimedia

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

TRANSLATIONS = translations/celladoor_pt_BR.ts translations/celladoor_it_IT.ts

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

target.path = $${PREFIX}/bin
INSTALLS += target

deb.commands = dpkg-buildpackage -rfakeroot -uc -us -sa -I.git $(DEB_EXTRA_OPTIONS)
QMAKE_EXTRA_TARGETS += deb
