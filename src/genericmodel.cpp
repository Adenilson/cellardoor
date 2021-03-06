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

#include "genericmodel.h"
#include "utils.h"
#include <QDebug>
#include <QtCore/QMetaProperty>
#include <QtCore/QStringList>

template <typename ModelTemplate>
GenericModel<ModelTemplate>::GenericModel(QObject *parent, bool cleanupPrefix)
    : GenericModelBase(parent), m_cleanup(cleanupPrefix), m_propertyCount(0)
{
    const ModelTemplate object;

    QStringList properties;
    ModelTemplate tmp;
    Utils::extractObjectProperties(tmp.metaObject(), &properties, m_cleanup);

    m_propertyCount = properties.count();
    for (int i = 0; i < m_propertyCount; ++i) {
        m_roles[i] = properties[i].toUtf8();
    }

}

template <typename ModelTemplate>
GenericModel<ModelTemplate>::~GenericModel()
{
    m_items.clear();
}

template <typename ModelTemplate>
void GenericModel<ModelTemplate>::addItem(const ModelTemplate &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << item;
    endInsertRows();
}

template <typename ModelTemplate>
void GenericModel<ModelTemplate>::prependItem(const ModelTemplate &item)
{
    beginInsertRows(QModelIndex(), 0, 0);
    m_items.prepend(item);
    endInsertRows();
}

template <typename ModelTemplate>
void GenericModel<ModelTemplate>::addItems(const QList<ModelTemplate> &items)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount() + items.size() - 1);
    m_items << items;
    endInsertRows();
}

template <typename ModelTemplate>
void GenericModel<ModelTemplate>::removeItem(const ModelTemplate &item)
{
    const int index = m_items.indexOf(item);
    beginRemoveRows(QModelIndex(), index, index);
    m_items.removeAt(index);
    endRemoveRows();
}

template <typename ModelTemplate>
void GenericModel<ModelTemplate>::clear()
{
    beginRemoveRows(QModelIndex(), 0, rowCount());
    m_items.clear();
    endRemoveRows();
}

template <typename ModelTemplate>
int GenericModel<ModelTemplate>::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);

    return m_items.count();
}

template <typename ModelTemplate>
QVariant GenericModel<ModelTemplate>::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > m_items.count())
        return QVariant();

    QVariant dataValue;
    const ModelTemplate item = m_items[index.row()];
    QMetaProperty metaProperty;

    for (int propertyIndex = 0; propertyIndex < m_propertyCount; ++propertyIndex) {
        if (role == propertyIndex) {
            const QMetaObject *tmp = item.metaObject();
            metaProperty = tmp->property(propertyIndex + tmp->propertyOffset());
            dataValue = item.property(metaProperty.name());
        }
    }

    return dataValue;
}

template <typename ModelTemplate>
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

template <typename ModelTemplate>
bool GenericModel<ModelTemplate>::updateItem(const ModelTemplate &item)
{
    int pos = m_items.indexOf(item);
    if (pos == -1)
        return false;

    QModelIndex m_index;
    m_index = index(pos);
    if (!(m_index.isValid()))
        return false;

    m_items.replace(pos, item);
    emit dataChanged(m_index, m_index);
    return true;
}

template <typename ModelTemplate>
QModelIndex GenericModel<ModelTemplate>::indexOfObject(const ModelTemplate &object)
{
    const int indexElement = m_items.indexOf(object);
    return index(indexElement);
}

template <typename ModelTemplate>
const QObject *GenericModel<ModelTemplate>::accessDataByIndex(int index)
{
    //XXX: check if object exists
    return qobject_cast<const QObject *>(&m_items.at(index));
}

template <typename ModelTemplate>
QList<ModelTemplate>& GenericModel<ModelTemplate>::items()
{
    return m_items;
}
