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
#include <QtCore/QStateMachine>
#include <QtCore/QState>

using namespace Utils;

/* TODOs:
 * vs 1.0
 * - Checkbox image: replace it with Designer's asset
 * - persistence of image (form 3)
 * - ui for image browsing
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
      m_map(new QDeclarativePropertyMap(this)),
      m_modelWine(new GenericModel<WineData>(this)),
      m_database(Database<WineData>::instance(this)),
      m_filter(new QStateMachine(this))
{
    m_view->rootContext()->setContextProperty("Controller", this);
    connect(m_map, SIGNAL(valueChanged(const QString &, const QVariant &)),
            this, SLOT(updateStorage(const QString &, const QVariant &)));

    m_view->rootContext()->setContextProperty("MainStorage", m_map);
    m_view->rootContext()->setContextProperty("WineModel", m_modelWine);

    connect(m_view->engine(), SIGNAL(quit()), this, SLOT(quit()));

    fillStorageProperties();
    setupFilterStates();
}

CellarController::~CellarController()
{
    delete m_view;
}

void CellarController::initUI()
{
    Environment tmp = static_cast<Environment>(Utils::environment());

    switch (tmp) {
    case SYMBIAN:
        m_view->setSource(QUrl("qrc:/qml/mainNosound.qml"));
        m_view->showFullScreen();
        break;

    case MAEMO:
        m_view->setSource(QUrl("qrc:/qml/main.qml"));
        m_view->showFullScreen();
        break;

    case WINDOWS:
      m_view->setSource(QUrl("qrc:/qml/mainNosound.qml"));
      m_view->show();
      break;

    default:
        m_view->setSource(QUrl("qrc:/qml/main.qml"));
        if (Utils::fullscreen())
            m_view->showFullScreen();
        else
            m_view->show();
        break;
    }

    QList<WineData> dataItems(m_database->retrieveTypes());
    if (dataItems.count())
        m_modelWine->addItems(dataItems);

    //TODO: set it within QML and only when required
    QTimer::singleShot(4000, this, SLOT(setScreen()));
}

void CellarController::setupFilterStates()
{
    QState *initial = new QState;
    QState *s0 = new QState(initial);
    s0->assignProperty(m_database, "filter", "id > -1");

    QState *s1 = new QState(initial);
    s1->assignProperty(m_database, "filter", "type = \"red\" OR type = \"white\"");

    QState *s2 = new QState(initial);
    s2->assignProperty(m_database, "filter", "type = \"red\"");

    QState *s3 = new QState(initial);
    s3->assignProperty(m_database, "filter", "type != \"red\"");

    QState *s4 = new QState(initial);
    s4->assignProperty(m_database, "filter", "type = \"white\"");

    QState *s5 = new QState(initial);
    s5->assignProperty(m_database, "filter", "type != \"red\" AND type != \"white\"");

    QState *s6 = new QState(initial);
    s6->assignProperty(m_database, "filter", "type != \"white\"");


    //XXX: not sure if this is the best approach
    initial->addTransition(this, SIGNAL(all()), s0);

    s0->addTransition(this, SIGNAL(redWhite()), s1);
    s0->addTransition(this, SIGNAL(red()), s2);
    s0->addTransition(this, SIGNAL(whiteOther()), s3);
    s0->addTransition(this, SIGNAL(white()), s4);
    s0->addTransition(this, SIGNAL(other()), s5);
    s0->addTransition(this, SIGNAL(redOther()), s6);

    s1->addTransition(this, SIGNAL(red()), s2);
    s1->addTransition(this, SIGNAL(whiteOther()), s3);
    s1->addTransition(this, SIGNAL(white()), s4);
    s1->addTransition(this, SIGNAL(other()), s5);
    s1->addTransition(this, SIGNAL(redOther()), s6);

    s2->addTransition(this, SIGNAL(redWhite()), s1);
    s2->addTransition(this, SIGNAL(whiteOther()), s3);
    s2->addTransition(this, SIGNAL(white()), s4);
    s2->addTransition(this, SIGNAL(other()), s5);
    s2->addTransition(this, SIGNAL(redOther()), s6);


    s3->addTransition(this, SIGNAL(redWhite()), s1);
    s3->addTransition(this, SIGNAL(red()), s2);
    s3->addTransition(this, SIGNAL(white()), s4);
    s3->addTransition(this, SIGNAL(other()), s5);
    s3->addTransition(this, SIGNAL(redOther()), s6);

    s4->addTransition(this, SIGNAL(redWhite()), s1);
    s4->addTransition(this, SIGNAL(red()), s2);
    s4->addTransition(this, SIGNAL(whiteOther()), s3);
    s4->addTransition(this, SIGNAL(other()), s5);
    s4->addTransition(this, SIGNAL(redOther()), s6);

    s5->addTransition(this, SIGNAL(redWhite()), s1);
    s5->addTransition(this, SIGNAL(red()), s2);
    s5->addTransition(this, SIGNAL(whiteOther()), s3);
    s5->addTransition(this, SIGNAL(white()), s4);
    s5->addTransition(this, SIGNAL(redOther()), s6);

    s6->addTransition(this, SIGNAL(redWhite()), s1);
    s6->addTransition(this, SIGNAL(red()), s2);
    s6->addTransition(this, SIGNAL(whiteOther()), s3);
    s6->addTransition(this, SIGNAL(white()), s4);
    s6->addTransition(this, SIGNAL(other()), s5);

    initial->setInitialState(s0);
    m_filter->addState(initial);
    m_filter->addState(s0);
    m_filter->addState(s1);
    m_filter->addState(s2);
    m_filter->addState(s3);
    m_filter->addState(s4);
    m_filter->addState(s5);
    m_filter->addState(s6);
    m_filter->setInitialState(initial);

    m_filter->start();
}

void CellarController::filter(const int &state)
{
    switch (state) {
    case 0:
        emit all();
        break;

    case 1:
        emit redWhite();
        break;

    case 2:
        emit red();
        break;

    case 3:
        emit whiteOther();
        break;

    case 4:
        emit white();
        break;

    case 5:
        emit other();
        break;

    case 6:
        emit redOther();
        break;

    default:
        m_modelWine->clear();
        return;
    }

    QList<WineData> dataItems;
    dataItems = m_database->retrieveTypes();
    if (dataItems.count()) {
        m_modelWine->clear();
        m_modelWine->addItems(dataItems);
    }
}

void CellarController::updateStorage(const QString &key, const QVariant &value)
{
    Q_UNUSED(key);
    Q_UNUSED(value);
    qDebug() << "UI changed wine data..." << value.toString();
}

void CellarController::createNewWine()
{
    qDebug() << "Creating a new wine...";
    WineData obj;
    obj.setName((*m_map)["name"].toString());
    obj.setType((*m_map)["type"].toString());
    obj.setGrape((*m_map)["grape"].toString());
    //TODO: missing in the UI
    //obj.setType((*m_map)["type"]);
    obj.setProducer((*m_map)["producer"].toString());
    obj.setYear((*m_map)["year"].toInt());
    obj.setPrice((*m_map)["price"].toFloat());

    obj.setTasting((*m_map)["tasting"].toString());
    obj.setComparison((*m_map)["comparison"].toString());
    obj.setLocation((*m_map)["location"].toString());
    obj.setDate((*m_map)["date"].toString());
    obj.setRate((*m_map)["rate"].toString());

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
    global["type"] = obj.type();
    global["grape"] = obj.grape();
    global["producer"] = obj.producer();
    global["year"] = obj.year();
    global["price"] = obj.price();

    global["tasting"] = obj.tasting();
    global["comparison"] = obj.comparison();
    global["location"] = obj.location();
    global["date"] = obj.date();
    global["rate"] = obj.rate();
    //TODO: emit a signal with done
}

void CellarController::editWine(int id)
{
    qDebug() << "Editing a wine card...";

    WineData obj;
    obj.setId(id);
    obj.setName((*m_map)["name"].toString());
    obj.setType((*m_map)["type"].toString());
    obj.setGrape((*m_map)["grape"].toString());
    //TODO: missing in the UI
    //obj.setType((*m_map)["type"]);
    obj.setProducer((*m_map)["producer"].toString());
    obj.setYear((*m_map)["year"].toInt());
    obj.setPrice((*m_map)["price"].toFloat());

    obj.setTasting((*m_map)["tasting"].toString());
    obj.setComparison((*m_map)["comparison"].toString());
    obj.setLocation((*m_map)["location"].toString());
    obj.setDate((*m_map)["date"].toString());
    obj.setRate((*m_map)["rate"].toString());

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
