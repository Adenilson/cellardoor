#include "controller.h"
#include "view.h"
#include "database.h"
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativePropertyMap>
#include <QtGlobal>
#include <QtCore/QDebug>

/* TODOs:
 * vs 1.0
 * - use a model from the Database
 * - allow edit operations
 * - allow delete operations
 * - implement missing forms
 * - and create the register with the new fields
 * - fancy animations
 *
 * vs 1.1
 * - barcode scan
 * vs 1.2
 * - google products search
 * vs 1.3
 * - social networks integration
 * vs 1.4
 * - a catalog of wine types and information
 */

CellarController::CellarController(QObject *parent)
    : QObject(parent), m_view(new CellarView),
      m_sysInfo(new QSystemDeviceInfo(parent)),
      m_map(new QDeclarativePropertyMap(this)),
      m_modelWine(new GenericModel<WineData>(this)),
      m_database(Database<WineData>::instance(this))
{
    m_view->rootContext()->setContextProperty("Controller", this);
    connect(m_map, SIGNAL(valueChanged(const QString &, const QVariant &)),
            this, SLOT(updateStorage(const QString &, const QVariant &)));

    m_view->rootContext()->setContextProperty("MainStorage", m_map);
    fillStorageProperties();
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

void CellarController::updateStorage(const QString &key, const QVariant &value)
{
    qDebug() << "UI changed wine data...";
}

void CellarController::createNewWine()
{
    qDebug() << "Creating a new wine...";
    WineData obj;
    obj.setName((*m_map)["name"].toString());
    obj.setGrape((*m_map)["grape"].toString());
    //TODO: missing in the UI
    //obj.setType((*m_map)["type"]);
    obj.setProducer((*m_map)["producer"].toString());
    obj.setYear((*m_map)["year"].toInt());
    obj.setPrice((*m_map)["price"].toFloat());
    //TODO: missing fields (region, tasting, etc)
    m_database->insertType(obj);
}

void CellarController::fillStorageProperties()
{
    QStringList properties;
    Utils::extractObjectProperties(WineData().metaObject(),
                                   &properties, true);
    foreach (const QString i, properties) {
        (*m_map)[i] = QVariant(QString("empty"));
    }
}
