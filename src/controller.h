#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include <QSystemDeviceInfo>
#include "genericmodel.h"
#include "wine.h"
#include "database.h"

class QDeclarativePropertyMap;
class CellarView;


QTM_USE_NAMESPACE

class CellarController : public QObject
{
    Q_OBJECT
public:
    CellarController(QObject *parent = 0);
    ~CellarController();

    void initUI();

public slots:
    void createNewWine();

protected slots:
    void updateStorage(const QString &key, const QVariant &value);
    void setScreen(int orientation = 2);

protected:
    void fillStorageProperties();

private:
    CellarView *m_view;
    QSystemDeviceInfo *m_sysInfo;
    QDeclarativePropertyMap *m_map;
    GenericModel<WineData> *m_modelWine;
    Database<WineData> *m_database;
};

#endif
