#include "wine.h"
#include <QtCore/QDebug>
#include <QtCore/QString>
#include <QtCore/QDate>
#include <QtCore/QMetaObject>
#include <QtCore/QMetaProperty>

class WineDataPrivate
{
public:
    WineDataPrivate(): id(-1), type(0), year(2011),
                       price(1.99), rate(10)
    { }

    int id;
    QString name;
    QString grape;
    char type;
    QString producer;
    QString region;
    uint year;
    float price;
    QString tasting;

    QString bottle;
    QString glass;
    QString cork;

    QString comments;
    QString comparisons;
    QString location;
    QString coordinates;
    QDate date;
    char rate;

};


WineData::WineData(QObject *parent): QObject(parent), dptr(new WineDataPrivate)
{

}

WineData::~WineData()
{
    delete dptr;
}

WineData::WineData(const WineData &data): QObject(data.parent()),
                                          dptr(new WineDataPrivate)
{
    operator=(data);
}

WineData &WineData::operator=(const WineData &data)
{
    //It works but looks ugly. Should I use the getter methods instead?
    dptr->id = data.dptr->id;
    dptr->name = data.dptr->name;
    dptr->grape = data.dptr->grape;
    dptr->type = data.dptr->type;
    dptr->producer = data.dptr->producer;
    dptr->region = data.dptr->region;
    dptr->year = data.dptr->year;
    dptr->price = data.dptr->price;
    dptr->tasting = data.dptr->tasting;
    dptr->bottle = data.dptr->bottle;
    dptr->glass = data.dptr->glass;
    dptr->cork = data.dptr->cork;
    dptr->comments = data.dptr->comments;

    dptr->comparisons = data.dptr->comparisons;
    dptr->location = data.dptr->location;
    dptr->coordinates = data.dptr->coordinates;
    dptr->date = data.dptr->date;
    dptr->rate = data.dptr->rate;

    return *this;
}

int WineData::id() const
{
    return dptr->id;
}

void WineData::setId(int &id)
{
    dptr->id = id;
}

QString WineData::name() const
{
    return dptr->name;
}

void WineData::setName(const QString &aname)
{
    dptr->name = aname;
}

QString WineData::grape() const
{
    return dptr->grape;
}
void WineData::setGrape(const QString &agrape)
{
    dptr->grape = agrape;
}

char WineData::type() const
{
    return dptr->type;
}

void WineData::setType(const char &atype)
{
    dptr->type = atype;
}

QString WineData::producer() const
{
    return dptr->producer;
}

void WineData::setProducer(const QString &aproducer)
{
    dptr->producer = aproducer;
}

QString WineData::region() const
{
    return dptr->region;
}

void WineData::setRegion(QString &aregion)
{
    dptr->region = aregion;
}

uint WineData::year() const
{
    return dptr->year;
}

void WineData::setYear(const uint ayear)
{
    dptr->year = ayear;
}

float WineData::price() const
{
    return dptr->price;
}

void WineData::setPrice(const float &aprice)
{
    dptr->price = aprice;
}

QString WineData::tasting() const
{
    return dptr->tasting;
}

void WineData::setTasting(const QString &ataste)
{
    dptr->tasting = ataste;
}
