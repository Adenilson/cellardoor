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

}

}
