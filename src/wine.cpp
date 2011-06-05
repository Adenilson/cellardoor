#include "wine.h"
#include <QtCore/QDebug>
#include <QtCore/QString>
#include <QtCore/QDate>

class WineDataPrivate
{
public:
    WineDataPrivate(): db_id(-1), db_type(0), db_year(2011),
                       db_price(1.99), db_rate(10)
    { }

    int db_id;
    QString db_name;
    QString db_grape;
    char db_type;
    QString db_producer;
    QString db_region;
    uint db_year;
    float db_price;
    QString db_tasting;

    QString db_bottle;
    QString db_glass;
    QString db_cork;

    QString db_comments;
    QString db_comparisons;
    QString db_location;
    QString db_coordinates;
    QDate db_date;
    char db_rate;

};


WineData::WineData(QObject *parent): QObject(parent), dptr(new WineDataPrivate)
{

}

WineData::~WineData()
{
    delete dptr;
}

int WineData::id() const
{

}

void WineData::setId(int &id)
{


}

QString WineData::name() const
{


}

void WineData::setName(QString &aname)
{

}

QString WineData::grape() const
{


}
void WineData::setGrape(QString &agrape)
{

}

char WineData::type() const
{

}

void WineData::setType(char atype)
{

}
