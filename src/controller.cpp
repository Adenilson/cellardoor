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


#include "controller.h"
#include "database.h"
#include "utils.h"
#include "view.h"
#include <QtCore/QDebug>
#include <QtCore/QDir>
#include <QtCore/QTimer>
#include <QtDeclarative/QDeclarativeContext>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativePropertyMap>
#include <QtGlobal>
#include <QtGui/QApplication>
#include <QtCore/QTranslator>

using namespace Utils;

/* TODOs:
 * vs 1.0
 * - RPM package
 * - fix upper bar separators
 * - merge Deutch internationalization
 * - detailed view
 * - handle internationalization of fields (wine color)
 * - MSI package (missing DLLs, test againt IUA, use real ID, handle signing)
 * - internationalization: french, spanish
 * - persistence of image (form 3)
 * - ui for image browsing
 * - logo for other grape types (Rose, Riesling, etc)
 * - fancy animations
 *
 * vs 1.1
 * - barcode scan
 * - geolocation (places of wine, reverse backmapping by name)
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
      m_translator(new QTranslator(this)),
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

    case WINDOWS: case OSX:
      m_view->setSource(QUrl("qrc:/qml/mainNosound.qml"));
      m_view->show();
      break;


    default:
        m_view->setSource(QUrl("qrc:/qml/mainNosound.qml"));
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

void CellarController::filter(const int &state)
{
    switch (state) {
    case 0:
        m_database->setFilter("id > -1");
        break;

    case 1:
        m_database->setFilter("type = \"red\" OR type = \"white\"");
        break;

    case 2:
        m_database->setFilter("type = \"red\"");
        break;

    case 3:
        m_database->setFilter("type != \"red\"");
        break;

    case 4:
        m_database->setFilter("type = \"white\"");
        break;

    case 5:
        m_database->setFilter("type != \"red\" AND type != \"white\"");
        break;

    case 6:
        m_database->setFilter("type != \"white\"");
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

void CellarController::changeLanguage(const QString &locale)
{
    m_app->removeTranslator(m_translator);
    QString file("celladoor_");
    file += locale;
    file += ".qm";

    // It will load from .qrc
    if (m_translator->load(file, ":/"))
        m_app->installTranslator(m_translator);
}

