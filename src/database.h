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

#ifndef _PERSISTENT_DATABASE_H_
#define _PERSISTENT_DATABASE_H_

#include <QtCore/QObject>
#include <QtSql/QSqlRecord>

class QSqlTableModel;

class DatabaseWorkaround: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString filter READ filter WRITE setFilter)

public:
    Q_ENUMS(Filter)
    enum Filter { NoFilter, OrderByAgeDesc };

public slots:
virtual void setFilter(const QString &query) = 0;
QString filter() const
{
    return m_filter;
}

protected:
DatabaseWorkaround(QObject *parent = 0): QObject(parent)
{ }

QString m_filter;

};

template <typename Type>
class Database: public DatabaseWorkaround
{

public:
    static Database *instance(QObject *parent = 0);

    bool insertType(Type &wine);
    bool deleteType(const Type &wine);
    bool updateType(const Type &wine);
    bool deleteTypeById(int id);

    QList<Type> retrieveTypes(Filter arg=NoFilter) const;

    void setFilter(const QString &query = "type = \"Red\"");

protected:
    Database(QObject *parent = 0);

private:
    void createDatabase();
    void setupModels();
    bool setType(const Type &data, int row, bool hasAutoIncrement = false);
    Type fillUpType(const QSqlRecord &record) const;

    QSqlTableModel *m_wineModel;
};

#include "database.cpp"

#endif
