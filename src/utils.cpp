/*  Copyright (C) 2011  Adenilson Cavalcanti <cavalcantii@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; by version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#include "utils.h"
#include <QtCore/QMetaObject>
#include <QtCore/QMetaProperty>
#include <QtCore/QStringList>
#include <QtGlobal>

namespace Utils {

void setOrientation(const Orientation &arg)
{
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
#elif defined(Q_WS_WIN)
    result = WINDOWS;
#elif defined(Q_WS_MAC)
    result = OSX;
#endif

    return result;
}

bool fullscreen()
{
    bool result = false;
/*
  QSystemDeviceInfo m_sysInfo;
    QString tmp(m_sysInfo.model());

    if (tmp.contains("Atom")) {
        result = true;
    }
*/
    return result;

}

}
