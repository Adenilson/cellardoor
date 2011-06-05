#ifndef _PERSISTENT_DATABASE_H_
#define _PERSISTENT_DATABASE_H_

#include <QtCore/QObject>
#include <QtSql/QSqlRecord>

#include "wine.h"

class QSqlTableModel;

class Database : public QObject
{
    Q_ENUMS(Filter)
public:
    static Database *instance(QObject *parent = 0);

    enum Filter {NoFilter, OrderByAgeDesc};

    bool insertWine(const WineData &wine);
    bool deleteWine(const WineData &wine);
    bool updateWine(const WineData &wine);

    bool deleteWineById(int id);

    QList<WineData> retrieveWines(Filter arg=NoFilter) const;

protected:
    Database(QObject *parent = 0);


private:
    void createDatabase();
    void setupModels();

    bool setWineData(const WineData &data, int row, bool hasAutoIncrement = false);
    WineData fillUpWineData(const QSqlRecord &record) const;

private:
    QSqlTableModel *m_wineModel;
};

#endif
