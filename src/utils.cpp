#include "utils.h"
#include <QtGlobal>
#include <QtCore/QStringList>
#include <QtCore/QMetaObject>
#include <QtCore/QMetaProperty>

//TODO: conditional compilation module instead of ifdef's
#ifdef Q_OS_SYMBIAN
#include <eikenv.h>
#include <coemain.h>
#include <aknappui.h>
#endif

#ifndef Q_WS_WIN
#ifndef Q_WS_MAC
#include <QSystemDeviceInfo>
QTM_USE_NAMESPACE
#endif
#endif

namespace Utils {

void setOrientation(const Orientation &arg)
{
#ifdef Q_OS_SYMBIAN
    CAknAppUi *aknAppUi = dynamic_cast<CAknAppUi *>(CEikonEnv::Static()->AppUi());
    if (!aknAppUi)
        return;

    switch (arg) {
    case LANDSCAPE:
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationLandscape);
        break;
    case PORTRAIT:
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationPortrait);
        break;
    case AUTO:
        aknAppUi->SetOrientationL(CAknAppUi::EAppUiOrientationAutomatic);
    }


#endif
    return;
}

void extractObjectProperties(const QMetaObject *object,
                             QStringList *list,
                             bool cleanup,
                             const char *prefix)
{
    QStringList &properties = *list;
    const int count = object->propertyCount();
    for (int i = 0; i < count; ++i) {
        QString propertyName = object->property(i).name();
        if (propertyName.startsWith(prefix)) {
            properties << propertyName;
        }
    }

    if (cleanup) {
        properties.replaceInStrings(prefix, "");
    }
}

int environment()
{
    int result = 0;
#if defined(Q_WS_X11)
    result = LINUX;
#elif defined(Q_WS_S60)
    result = SYMBIAN;
#elif defined(Q_WS_WIN)
    result = WINDOWS;
#elif defined(Q_WS_MAEMO)
    result = MAEMO;
#elif defined(Q_WS_MAC)
    result = OSX;
#endif

    return result;
}

bool fullscreen()
{
    bool result = false;
//FIXME: most probably will fail in OSX
#ifndef Q_WS_WIN
#ifndef Q_WS_MAC
    QSystemDeviceInfo m_sysInfo;
    QString tmp(m_sysInfo.model());

    if (tmp.contains("Atom")) {
        result = true;
    }
#endif
#endif

    return result;

}

}
