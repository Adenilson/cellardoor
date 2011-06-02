#include "controller.h"
#include "view.h"
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative>
#include <QtGlobal>
#include <QtCore/QDebug>

CellarController::CellarController(QObject *parent)
    : QObject(parent), m_view(new CellarView),
      m_sysInfo(new QSystemDeviceInfo(parent)),
      m_map(new QDeclarativePropertyMap(this))
{
    m_view->rootContext()->setContextProperty("controller", this);
    (*m_map)["name"] = QVariant(QString("Santa Elena"));
    (*m_map)["type"] = QVariant(QString("Cabernet Sauvignon"));
    m_view->rootContext()->setContextProperty("MainStorage", m_map);
}

CellarController::~CellarController()
{
    delete m_view;
    delete m_sysInfo;
}

void CellarController::initUI()
{

    QString tmp(m_sysInfo->model());
    //XXX: At least in mobility 1.2 beta1 in Symbian^3 it fails to load
    if (tmp.contains("i686"))
        m_view->setSource(QUrl("qrc:/qml/main.qml"));
    else {
        if (tmp.contains("Atom")) {
            m_view->setSource(QUrl("qrc:/qml/main.qml"));
        } else {
            m_view->setSource(QUrl("qrc:/qml/mainNosound.qml"));
        }

        m_view->showFullScreen();
    }
}
