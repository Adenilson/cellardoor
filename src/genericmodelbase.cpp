#include "genericmodelbase.h"
#include <QMetaType>

GenericModelBase::GenericModelBase(QObject *parent)
    : QAbstractListModel(parent)
{
}

GenericModelBase::~GenericModelBase()
{
}

void GenericModelBase::getByIndex(int index)
{
    emit populateCurrentItem(accessDataByIndex(index));
}
