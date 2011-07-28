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

//#include "database.h"
#include "utils.h"

#include <QtCore/QDir>
#include <QtGui/QDesktopServices>
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlTableModel>
#include <QtSql/QSqlQuery>
#include <QtSql/QSqlError>
#include <QtSql/QSqlRecord>
#include <QtSql/QSqlField>
#include <QtCore/QCoreApplication>
//TODO: support the prefix as a parameter
const char DB_PREFIX[] = "db_";

#include <QtCore/QDebug>

template <class Type>
Database<Type>::Database(QObject *parent)
  : DatabaseWorkaround(parent)
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

template <class Type>
void Database<Type>::createDatabase()
{
    QSqlQuery query(QSqlDatabase::database());

    QStringList propertiesList;
    //TODO: support prefixes in properties to be persisted
    Utils::extractObjectProperties(Type().metaObject(),
                                   &propertiesList, false, DB_PREFIX);

    propertiesList.replaceInStrings(QRegExp(QString("^") + DB_PREFIX), "").replaceInStrings("id", "id integer primary key autoincrement");
    query.exec("create table if not exists wines (" + propertiesList.join(", ") + ")");
}

template <class Type>
void Database<Type>::setupModels()
{
    QSqlDatabase db = QSqlDatabase::database();

    m_wineModel = new QSqlTableModel(this, db);
    m_wineModel->setTable("wines");
    m_wineModel->setEditStrategy(QSqlTableModel::OnManualSubmit);
}

template <class Type>
Database<Type> *Database<Type>::instance(QObject *parent)
{
    static Database *s_instance = 0;

    if (!s_instance) {
        s_instance = new Database(parent);
    }

    return s_instance;
}

template <class Type>
bool Database<Type>::insertType(Type &wine)
{
    bool hasError = false;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        return hasError;
    }

    m_wineModel->select();
    m_wineModel->insertRows(0, 1);
    hasError = setType(wine, 0, true);

    if (!hasError) {
        qCritical() << "Failed to insert a wine";
        return hasError;
    }

    //FIXME: this will work sometimes will fail
    m_wineModel->setSort(0, Qt::DescendingOrder);
    if (!m_wineModel->select()) {
        qCritical() << "Failed to update the model...";
        return hasError;
    }

    qDebug() << "COUNT: " << m_wineModel->rowCount();
    QSqlRecord tmp(m_wineModel->record(0));
    if (!tmp.isEmpty()) {
        QSqlField data(tmp.field("id"));
        if (!data.isNull()) {
            int id = data.value().toInt();
            wine.setId(id);
            qDebug() << "######## ID: " << id;
        } else {
            qDebug() << "Failed to find the field."
                     << data;
        }
    } else
        qDebug() << "Failed to update the ID";


error:
    return hasError;
}

template <class Type>
bool Database<Type>::deleteType(const Type &wine)
{
    return deleteTypeById(wine.id());
}

template <class Type>
bool Database<Type>::deleteTypeById(int id)
{
    bool hasError = false;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        goto error;
    }

    m_wineModel->setFilter("id = " + QString::number(id));
    m_wineModel->select();

    if (!m_wineModel->rowCount()) {
        qDebug() << "Type does not exist";
        goto error;
    }

    m_wineModel->removeRows(0, 1);
    hasError = m_wineModel->submitAll();

error:
    return hasError;
}

template <class Type>
bool Database<Type>::updateType(const Type &wine)
{
    bool hasError = false;

    if (!m_wineModel) {
        qCritical() << "Unable to insert a wine";
        goto error;
    }

    m_wineModel->setFilter("id = " + QString::number(wine.id()));
    m_wineModel->select();
    if (m_wineModel->rowCount() == 1) {
        hasError = setType(wine, 0);
        goto error;
    }

error:
    return hasError;
}

template <class Type>
void Database<Type>::setFilter(const QString &query)
{

    if (!m_wineModel) {
        qCritical() << "Unable to filter table!";
        return;
    }

    m_filter = query;
    m_wineModel->setFilter(query);
    m_wineModel->select();
}

template <class Type>
bool Database<Type>::setType(const Type &data, int row, bool hasAutoIncrement)
{
    QStringList propertiesList;
    Utils::extractObjectProperties(data.metaObject(),
                                   &propertiesList, false, DB_PREFIX);
    foreach(const QString &property, propertiesList) {
        if (!hasAutoIncrement || !property.contains("id")) {
            int fieldIndex = m_wineModel->fieldIndex(QString(property).remove(DB_PREFIX));
            if (fieldIndex >= 0) {
                m_wineModel->setData(m_wineModel->index(row, fieldIndex),
                                         data.property(qPrintable(property)));
            }
        }
    }

    return m_wineModel->submitAll();
}


template <class Type>
Type Database<Type>::fillUpType(const QSqlRecord &record) const
{
    Type item;

    QStringList list;
    Utils::extractObjectProperties(item.metaObject(), &list, false, DB_PREFIX);
    foreach (const QString &property, list) {
        item.setProperty(qPrintable(property), record.value(QString(property).remove(DB_PREFIX)));
    }

    return item;
}

template <class Type>
QList<Type> Database<Type>::retrieveTypes(Filter arg) const
{
    QList<Type> wineList;

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
        wineList << fillUpType(record);
    }

exit:
    return wineList;
}
