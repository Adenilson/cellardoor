#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include <QSystemDeviceInfo>
#include "genericmodel.h"
#include "wine.h"
class QDeclarativePropertyMap;
class CellarView;
class Database;

QTM_USE_NAMESPACE

class CellarController : public QObject
{
    Q_OBJECT
public:
    CellarController(QObject *parent = 0);
    ~CellarController();

    void initUI();

protected slots:
    void updateStorage(const QString &key, const QVariant &value);

private:
    CellarView *m_view;
    QSystemDeviceInfo *m_sysInfo;
    QDeclarativePropertyMap *m_map;
    GenericModel<WineData> *m_modelWine;
    Database *m_database;
};

#endif
