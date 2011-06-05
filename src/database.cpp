#include "database.h"

#include <QtCore/QDir>
#include <QtGui/QDesktopServices>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlTableModel>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtCore/QCoreApplication>

#include <QtCore/QDebug>

Database::Database(QObject *parent)
  : QObject(parent)
{
    QSqlDatabase db(QSqlDatabase::addDatabase("QSQLITE"));
    const QDir dbDir(QDesktopServices::storageLocation(QDesktopServices::DataLocation));
    const QString databaseName = QString("wine_" + QCoreApplication::applicationVersion() + ".db");

#ifndef Q_OS_SYMBIAN
    if (!dbDir.exists()) {
        if (!dbDir.mkpath(dbDir.path())) {
            qCritical() << "Could not create database path: " << dbDir.path();
        }
    }

    const QString databasePath = dbDir.path() + "/" + databaseName;
#else
    const QString databasePath = "C:\\" + databaseName;
#endif
    qDebug() << databasePath;
    db.setDatabaseName(databasePath);
    if (!db.open()) {
        qCritical() << "Could not open database: " << db.lastError();
        exit(-1);
    }

    createDatabase();
    setupModels();
}

void Database::createDatabase()
{
    QSqlQuery query(QSqlDatabase::database());

    const QStringList propertiesList =  WineData().objectDbProperties()
                                        .replaceInStrings(QRegExp("^db_"), "")
                                        .replaceInStrings("id", "id integer primary key autoincrement");
    query.exec("create table if not exists wines (" + propertiesList.join(", ") + ")");
}

void Database::setupModels()
{
    QSqlDatabase db = QSqlDatabase::database();

    m_wineModel = new QSqlTableModel(this, db);
    m_wineModel->setTable("wines");
    m_wineModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
}

Database *Database::instance(QObject *parent)
{
    static Database *s_instance = 0;

    if (!s_instance) {
        s_instance = new Database(parent);
    }

    return s_instance;
}

bool Database::insertWine(const WineData &wine)
{
    bool hasError = false;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        goto error;
    }

    m_wineModel->select();
    m_wineModel->insertRows(0, 1);
    hasError = setWineData(wine, 0, true);

error:
    return hasError;
}

bool Database::deleteWine(const WineData &wine)
{
    return deleteWineById(wine.id());
}

bool Database::deleteWineById(int id)
{
    bool hasError = false;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        goto error;
    }

    m_wineModel->setFilter("id = " + QString::number(id));
    m_wineModel->select();

    if (!m_wineModel->rowCount()) {
        qDebug() << "Wine does not exist";
        goto error;
    }

    m_wineModel->removeRows(0, 1);
    hasError = m_wineModel->submitAll();

error:
    return hasError;
}

bool Database::updateWine(const WineData &wine)
{
    bool hasError = false;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        goto error;
    }

    m_wineModel->setFilter("id = " + QString::number(wine.id()));
    m_wineModel->select();
    if (m_wineModel->rowCount() == 1) {
        hasError = setWineData(wine, 0);
        goto error;
    }

error:
    return hasError;
}

bool Database::setWineData(const WineData &data, int row, bool hasAutoIncrement)
{
    QStringList propertiesList(data.objectDbProperties());
    foreach(const QString &property, propertiesList) {
        if (!hasAutoIncrement || !property.contains("id")) {
            int fieldIndex = m_wineModel->fieldIndex(QString(property).remove("db_"));
            if (fieldIndex >= 0) {
                m_wineModel->setData(m_wineModel->index(row, fieldIndex),
                                         data.property(qPrintable(property)));
            }
        }
    }

    return m_wineModel->submitAll();
}


WineData Database::fillUpWineData(const QSqlRecord &record) const
{
    WineData item;

    const QStringList list(item.objectDbProperties());
    foreach (const QString &property, list) {
        item.setProperty(qPrintable(property), record.value(QString(property).remove("db_")));
    }

    return item;
}

QList<WineData> Database::retrieveWines(Filter arg) const
{
    QList<WineData> wineList;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        goto exit;
    }

    if (arg == OrderByAgeDesc) {
        m_wineModel->setSort(4, Qt::DescendingOrder);
    }
    m_wineModel->select();

    for (int i = 0; i < m_wineModel->rowCount(); ++i) {
        const QSqlRecord record = m_wineModel->record(i);
        wineList << fillUpWineData(record);
    }

exit:
    return wineList;
}
