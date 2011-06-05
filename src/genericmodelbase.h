#ifndef __GENERICMODELBASE_H__
#define __GENERICMODELBASE_H__

#include <QtCore/QAbstractListModel>

class GenericModelBase : public QAbstractListModel
{
    Q_OBJECT

public:
    GenericModelBase(QObject *parent = 0);
    virtual ~GenericModelBase();

public Q_SLOTS:
    void getByIndex(int index);

Q_SIGNALS:
    void populateCurrentItem(const QObject *object);

protected:
    virtual const QObject *accessDataByIndex(int index) = 0;
};

#endif
