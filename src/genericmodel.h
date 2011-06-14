#ifndef _GENERICMODEL_H_
#define _GENERICMODEL_H_

#include "genericmodelbase.h"

#include <QtCore/QAbstractListModel>
#include <QtCore/QList>

template <class ModelTemplate>
class GenericModel : public GenericModelBase
{

public:
    GenericModel(QObject *parent = 0, bool cleanupPrefix = true);
    ~GenericModel();

    void addItem(const ModelTemplate &item);
    void prependItem(const ModelTemplate &item);
    void addItems(const QList<ModelTemplate> &items);
    void removeItem(const ModelTemplate &item);

    void clear();

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    bool setData(const QModelIndex & index, const QVariant & value, int role = Qt::EditRole);
    QModelIndex indexOfObject(const ModelTemplate &object);

protected:
    const QObject *accessDataByIndex(int id);

private:
    QList<ModelTemplate> m_items;
    bool m_cleanup;
};

#include "genericmodel.cpp"

#endif
