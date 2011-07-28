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

#include "wine.h"
#include <QtCore/QDebug>
#include <QtCore/QString>
#include <QtCore/QDate>
#include <QtCore/QMetaObject>
#include <QtCore/QMetaProperty>

class WineDataPrivate
{
public:
    WineDataPrivate(): id(-1), type("red"), year(2011),
                       price(1.99), rate(10)
    { }

    int id;
    QString name;
    QString grape;
    QString type;
    QString producer;
    QString region;
    uint year;
    float price;
    QString tasting;

    QString bottle;
    QString glass;
    QString cork;

    QString comparison;
    QString location;
    QString date;
    QString rate;

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
    //dptr->comments = data.dptr->comments;

    dptr->comparison = data.dptr->comparison;
    dptr->location = data.dptr->location;
    //dptr->coordinates = data.dptr->coordinates;
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

QString WineData::type() const
{
    return dptr->type;
}

void WineData::setType(const QString &atype)
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

bool WineData::operator==(const WineData &data) const
{
    bool result = false;
    //XXX: I only need the ID
    if (dptr) {
        result = (dptr->id == data.dptr->id);
    }

    return result;
}

QString WineData::comparison() const
{
    return dptr->comparison;
}

void WineData::setComparison(const QString &comparison)
{
    dptr->comparison = comparison;
}

QString WineData::location() const
{
    return dptr->location;

}

void WineData::setLocation(const QString &place)
{
    dptr->location = place;
}

QString WineData::date() const
{
    return dptr->date;
}

void WineData::setDate(const QString &date)
{
    dptr->date = date;
}

QString WineData::rate() const
{
    return dptr->rate;
}

void WineData::setRate(const QString &rate)
{
    dptr->rate = rate;
}
