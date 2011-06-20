#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include <QSystemDeviceInfo>
#include "genericmodel.h"
#include "wine.h"
#include "database.h"

class QDeclarativePropertyMap;
class CellarView;
class QApplication;

QTM_USE_NAMESPACE

class CellarController : public QObject
{
    Q_OBJECT
public:
    CellarController(QObject *parent = 0, QApplication *application = 0);
    ~CellarController();

    void initUI();

public slots:
    int wineCount();
    void createNewWine();
    void quit();

protected slots:
    void updateStorage(const QString &key, const QVariant &value);
    void setScreen(int orientation = 2);

protected:
    void fillStorageProperties();

private:
    QApplication *m_app;
    CellarView *m_view;
    QSystemDeviceInfo *m_sysInfo;
    QDeclarativePropertyMap *m_map;
    GenericModel<WineData> *m_modelWine;
    Database<WineData> *m_database;
};

#endif
