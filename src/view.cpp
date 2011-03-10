#include "controller.h"
#include "view.h"

#include <QtDeclarative/QDeclarativeContext>

ReminderView::ReminderView(QWidget *parent)
 : QDeclarativeView(parent)
{
    connect(this, SIGNAL(statusChanged(QDeclarativeView::Status)), this, SLOT(onStatusChanged(QDeclarativeView::Status)));
    resize(360, 640);
}

ReminderView::~ReminderView()
{
}

void ReminderView::onStatusChanged(QDeclarativeView::Status status)
{
    if (status == QDeclarativeView::Ready) {
#if defined(Q_WS_MAEMO5) || defined(PUSHED_MEEGO_HARMATTAN) || defined(Q_OS_SYMBIAN)
        showFullScreen();
#else
        show();
#endif
    }
}

bool ReminderView::event(QEvent *event)
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
