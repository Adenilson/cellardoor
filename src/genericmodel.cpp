#include "genericmodel.h"
#include "utils.h"
#include <QtCore/QMetaProperty>
#include <QtCore/QStringList>
#include <QDebug>

template <class ModelTemplate>
GenericModel<ModelTemplate>::GenericModel(QObject *parent, bool cleanupPrefix)
    : GenericModelBase(parent), m_cleanup(cleanupPrefix)
{
    const ModelTemplate object;
    QHash<int, QByteArray> roles;

    QStringList properties;
    ModelTemplate tmp;
    Utils::extractObjectProperties(tmp.metaObject(), &properties, m_cleanup);

    for (int i = 0; i < properties.count(); ++i) {
        roles[i] = properties[i].toUtf8();
    }

    setRoleNames(roles);
}

template <class ModelTemplate>
GenericModel<ModelTemplate>::~GenericModel()
{
    m_items.clear();
}

template <class ModelTemplate>
void GenericModel<ModelTemplate>::addItem(const ModelTemplate &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << item;
    endInsertRows();
}

template <class ModelTemplate>
void GenericModel<ModelTemplate>::prependItem(const ModelTemplate &item)
{
    beginInsertRows(QModelIndex(), 0, 0);
    m_items.prepend(item);
    endInsertRows();
}

template <class ModelTemplate>
void GenericModel<ModelTemplate>::addItems(const QList<ModelTemplate> &items)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount() + items.size() - 1);
    m_items << items;
    endInsertRows();
}

template <class ModelTemplate>
void GenericModel<ModelTemplate>::removeItem(const ModelTemplate &item)
{
    const int index = m_items.indexOf(item);
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

template <class ModelTemplate>
void GenericModel<ModelTemplate>::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount());
    m_items.clear();
    endRemoveRows();
}

template <class ModelTemplate>
int GenericModel<ModelTemplate>::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);

    return m_items.count();
}

template <class ModelTemplate>
QVariant GenericModel<ModelTemplate>::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_items.count())
        return QVariant();

    QVariant dataValue;
    const ModelTemplate item = m_items[index.row()];
    const int propertyCount = item.metaObject()->propertyCount();
    QMetaProperty metaProperty;

    for (int propertyIndex = 0; propertyIndex < propertyCount; ++propertyIndex) {
        if (role == propertyIndex) {
            metaProperty = item.metaObject()->property(propertyIndex);
            dataValue = item.property(metaProperty.name());
        }
    }

    return dataValue;
}

template <class ModelTemplate>
bool GenericModel<ModelTemplate>::setData(const QModelIndex & index, const QVariant & value, int role)
{
    if (!index.isValid())
        return false;

    ModelTemplate item = m_items.at(index.row());
    item.setProperty(item.metaObject()->property(role).name(), value);
    m_items.replace(index.row(), item);
    emit dataChanged(index, index);
    return true;
}

template <class ModelTemplate>
QModelIndex GenericModel<ModelTemplate>::indexOfObject(const ModelTemplate &object)
{
    const int indexElement = m_items.indexOf(object);
    return index(indexElement);
}

template <class ModelTemplate>
const QObject *GenericModel<ModelTemplate>::accessDataByIndex(int index)
{
    //XXX: check if object exists
    return qobject_cast<const QObject *>(&m_items.at(index));
}
