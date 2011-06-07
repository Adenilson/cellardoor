#ifndef _PERSISTENT_DATABASE_H_
#define _PERSISTENT_DATABASE_H_

#include <QtCore/QObject>
#include <QtSql/QSqlRecord>

class QSqlTableModel;

class DatabaseWorkaround: public QObject
{
Q_OBJECT
    public:
Q_ENUMS(Filter)
    enum Filter { NoFilter, OrderByAgeDesc };

protected:
DatabaseWorkaround(QObject *parent = 0): QObject(parent)
{ }

};

template <typename Type>
class Database: public DatabaseWorkaround
{

public:
    static Database *instance(QObject *parent = 0);

    bool insertType(const Type &wine);
    bool deleteType(const Type &wine);
    bool updateType(const Type &wine);
    bool deleteTypeById(int id);

    QList<Type> retrieveTypes(Filter arg=NoFilter) const;

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
