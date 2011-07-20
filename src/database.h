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
