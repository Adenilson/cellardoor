#ifndef __WINEDATA_H__
#define __WINEDATA_H__

#include <QtCore/QObject>

class WineDataPrivate;

class WineData: public QObject
{
    Q_OBJECT

    Q_PROPERTY(int db_id READ id WRITE setId)
    Q_PROPERTY(QString db_name READ name WRITE setName)
    Q_PROPERTY(QString db_grape READ grape WRITE setGrape)
    Q_PROPERTY(char db_type READ type WRITE setType)

    Q_PROPERTY(QString db_producer READ producer WRITE setProducer)
    Q_PROPERTY(QString db_region READ region  WRITE setRegion)
    Q_PROPERTY(uint db_year READ year WRITE setYear)
    Q_PROPERTY(float db_price READ price WRITE setPrice)
    Q_PROPERTY(QString db_tasting READ  tasting WRITE setTasting)
/*
    Q_PROPERTY(QString db_bottle READ bottle WRITE setBottle)
    Q_PROPERTY(QString db_glass READ glass WRITE setGlass)
    Q_PROPERTY(QString db_cork READ cork WRITE setCork)
    Q_PROPERTY(QString db_coordinates READ coordinates WRITE setCoordinates)
*/
    Q_PROPERTY(QString db_comparison READ comparison WRITE setComparison)
    Q_PROPERTY(QString db_location READ location  WRITE setLocation)
    Q_PROPERTY(QString db_date READ date WRITE setDate)
    Q_PROPERTY(QString db_rate READ rate WRITE setRate)


public:
    WineData(QObject *parent = 0);

    WineData(const WineData &data);

    WineData &operator=(const WineData &data);
    bool operator==(const WineData &data) const;

    ~WineData();

    //Setters/getters
    int id() const;
    void setId(int &id);

    QString name() const;
    void setName(const QString &aname);

    QString grape() const;
    void setGrape(const QString &agrape);

    char type() const;
    void setType(const char &atype);

    QString producer() const;
    void setProducer(const QString &aproducer);

    QString region() const;
    void setRegion(QString &aregion);

    uint year() const;
    void setYear(const uint ayear);

    float price() const;
    void setPrice(const float &aprice);

    QString tasting() const;
    void setTasting(const QString &ataste);

    QString comparison() const;
    void setComparison(const QString &comparison);

    QString location() const;
    void setLocation(const QString &place);

    QString date() const;
    void setDate(const QString &date);

    QString rate() const;
    void setRate(const QString &rate);

protected:
    WineDataPrivate *dptr;

};



#endif
