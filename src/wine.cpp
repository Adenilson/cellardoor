#include "wine.h"
#include <QtCore/QDebug>
#include <QtCore/QString>
#include <QtCore/QDate>

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

WineData::WineData(const WineData &data)
{
    operator=(data);
    if (data.parent()) {
        setParent(data.parent());
    }
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

void WineData::setName(const QString &aname)
{

}

QString WineData::grape() const
{


}
void WineData::setGrape(const QString &agrape)
{

}

char WineData::type() const
{

}

void WineData::setType(const char &atype)
{

}

QString WineData::producer() const
{

}

void WineData::setProducer(const QString &aproducer)
{

}

QString WineData::region() const
{


}

void WineData::setRegion(QString &aregion)
{


}

uint WineData::year() const
{

}

void WineData::setYear(const uint ayear)
{

}

float WineData::price() const
{

}

void WineData::setPrice(const float &aprice)
{

}

QString WineData::tasting() const
{


}

void WineData::setTasting(const QString &ataste)
{

}
