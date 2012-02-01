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

#include "view.h"

#include <QtDeclarative/QDeclarativeContext>
#include "qmlprofilerhelper.h"

CellarView::CellarView(QWidget *parent)
 : QDeclarativeView(parent)
{
    connect(this, SIGNAL(statusChanged(QDeclarativeView::Status)), this, SLOT(onStatusChanged(QDeclarativeView::Status)));
    resize(360, 640);
    setResizeMode(SizeRootObjectToView);
    startProfiler(this, engine());
}

CellarView::~CellarView()
{
}

void CellarView::onStatusChanged(QDeclarativeView::Status status)
{
    if (status == QDeclarativeView::Ready) {
#if defined(Q_WS_MAEMO5) || defined(PUSHED_MEEGO_HARMATTAN) || defined(Q_OS_SYMBIAN)
        showFullScreen();
#else
        show();
#endif
    }
}

bool CellarView::event(QEvent *event)
{
    switch (event->type()) {
    case QEvent::Gesture:
        event->accept();
        break;
    case QEvent::GestureOverride:
        event->accept();
        break;
    default:
        break;
    }

    return QGraphicsView::event(event);
}
