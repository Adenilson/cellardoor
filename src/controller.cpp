#include "controller.h"
#include "view.h"
#include "database.h"
#include "utils.h"
#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativePropertyMap>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtGlobal>
#include <QtCore/QDebug>
#include <QtCore/QTimer>
#include <QtCore/QDir>

/* TODOs:
 * vs 1.0
 * - fix newly added bug (fails to edit or delete thanks to missing ID)
 * - futher info (form 2)
 * - ui for image browsing
 * - query by: kind (red/white/etc), name, region
 * - geolocation (places of wine, reverse backmapping by name)
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

CellarController::CellarController(QObject *parent, QApplication *application)
    : QObject(parent), m_app(application), m_view(new CellarView),
      m_sysInfo(new QSystemDeviceInfo(parent)),
      m_map(new QDeclarativePropertyMap(this)),
      m_modelWine(new GenericModel<WineData>(this)),
      m_database(Database<WineData>::instance(this))
{
    m_view->rootContext()->setContextProperty("Controller", this);
    connect(m_map, SIGNAL(valueChanged(const QString &, const QVariant &)),
            this, SLOT(updateStorage(const QString &, const QVariant &)));

    m_view->rootContext()->setContextProperty("MainStorage", m_map);
    m_view->rootContext()->setContextProperty("WineModel", m_modelWine);

    connect(m_view->engine(), SIGNAL(quit()), this, SLOT(quit()));

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

    QList<WineData> dataItems(m_database->retrieveTypes());
    if (dataItems.count())
        m_modelWine->addItems(dataItems);

    //TODO: set it within QML and only when required
    QTimer::singleShot(4000, this, SLOT(setScreen()));
}

void CellarController::updateStorage(const QString &key, const QVariant &value)
{
    Q_UNUSED(key);
    Q_UNUSED(value);
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

    m_modelWine->addItem(obj);
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

void CellarController::setScreen(int orientation)
{
    Utils::setOrientation(static_cast<Utils::Orientation>(orientation));
}

void CellarController::quit()
{
    if (m_app) {
        m_app->exit();
    }
}

int CellarController::wineCount()
{
    int result = 0;
    if (m_modelWine)
        result = m_modelWine->rowCount();

    return result;
}

void CellarController::deleteWine(int id)
{
    m_database->deleteTypeById(id);
    WineData obj;
    obj.setId(id);
    m_modelWine->removeItem(obj);
}

void CellarController::fillStorage(int id)
{
    WineData obj;
    QDeclarativePropertyMap &global = *m_map;
    QList<WineData> &items = m_modelWine->items();
    int tmp;

    obj.setId(id);
    tmp = items.indexOf(obj);
    if (tmp == -1) {
        //TODO: emit a signal with error
        return;
    }

    obj = items[tmp];
    global["name"] = obj.name();
    global["grape"] = obj.grape();
    global["producer"] = obj.producer();
    global["year"] = obj.year();
    global["price"] = obj.price();
    //TODO: emit a signal with done
}

void CellarController::editWine(int id)
{
    qDebug() << "Editing a wine card...";

    WineData obj;
    obj.setId(id);
    obj.setName((*m_map)["name"].toString());
    obj.setGrape((*m_map)["grape"].toString());
    //TODO: missing in the UI
    //obj.setType((*m_map)["type"]);
    obj.setProducer((*m_map)["producer"].toString());
    obj.setYear((*m_map)["year"].toInt());
    obj.setPrice((*m_map)["price"].toFloat());
    //TODO: missing fields (region, tasting, etc)

    if (m_database->updateType(obj)) {

        m_modelWine->updateItem(obj);

    } else {

        qDebug() << "Can't edit. Are you sure that this exits?";
    }
}


QString CellarController::workingDir()
{
    QString result("file://");
    result += QDir::currentPath();
    result += "/";
    return result;
}

int CellarController::system()
{
    return Utils::environment();
}
