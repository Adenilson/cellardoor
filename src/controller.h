#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include <QSystemDeviceInfo>

class CellarView;

QTM_USE_NAMESPACE

class CellarController : public QObject
{
    Q_OBJECT
public:
    CellarController(QObject *parent = 0);
    ~CellarController();

    void initUI();

private:
    CellarView *m_view;
    QSystemDeviceInfo *m_sysInfo;
};

#endif
