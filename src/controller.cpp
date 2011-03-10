#include "controller.h"
#include "view.h"
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative>
#include <QtGlobal>

#ifndef Q_OS_SYMBIAN
#define DEBUG
#endif

ReminderController::ReminderController(QObject *parent)
    : QObject(parent), m_view(new ReminderView)
{
    m_view->rootContext()->setContextProperty("controller", this);

}

ReminderController::~ReminderController()
{
    delete m_view;
}

void ReminderController::initUI()
{
#ifdef DEBUG
    m_view->setSource(QUrl("qml/main.qml"));
#else
    m_view->setSource(QUrl("qrc:/qml/main.qml"));
#endif

}
