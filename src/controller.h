#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include "genericmodel.h"
#include "wine.h"
#include "database.h"

class QDeclarativePropertyMap;
class CellarView;
class QApplication;
class QStateMachine;

class CellarController : public QObject
{
    Q_OBJECT
public:
    CellarController(QObject *parent = 0, QApplication *application = 0);
    ~CellarController();

    void initUI();

public slots:
    void editWine(int id);
    void fillStorage(int id);
    void deleteWine(int id);
    int wineCount();
    void createNewWine();

    void quit();
    QString workingDir();
    int system();


    void filter(const int &state);

signals:
    void red();
    void all();
    void redWhite();
    void whiteOther();
    void redOther();
    void white();
    void other();

protected slots:
    void updateStorage(const QString &key, const QVariant &value);
    void setScreen(int orientation = 2);

protected:
    void fillStorageProperties();
    void setupFilterStates();

private:
    QApplication *m_app;
    CellarView *m_view;
    QDeclarativePropertyMap *m_map;
    GenericModel<WineData> *m_modelWine;
    Database<WineData> *m_database;
    QStateMachine *m_filter;
};

#endif
