include(scripts/scripts.pri)

QT       += core gui network quick sql multimedia

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
    resources.qrc \
    translations.qrc

INCLUDEPATH += \
               src

TRANSLATIONS = translations/celladoor_pt_BR.ts translations/celladoor_it_IT.ts translations/celladoor_de_DE.ts translations/celladoor_fr_FR.ts translations/celladoor_es_ES.ts

include(src/profile.pri)

target.path = $${PREFIX}/bin
INSTALLS += target

i18n.files = $${SOURCE_TREE}/celladoor_pt_BR.qm $${SOURCE_TREE}/celladoor_it_IT.qm $${SOURCE_TREE}/celladoor_de_DE.qm $${SOURCE_TREE}/celladoor_fr_FR.qm $${SOURCE_TREE}/celladoor_es_ES.qm
i18n.path = $${PREFIX}/share/$${TARGET}/i18n
INSTALLS += i18n

deb.commands = dpkg-buildpackage -rfakeroot -uc -us -sa -I.git $(DEB_EXTRA_OPTIONS)
QMAKE_EXTRA_TARGETS += deb
