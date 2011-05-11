#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include <QSystemDeviceInfo>

class ReminderView;

QTM_USE_NAMESPACE

class ReminderController : public QObject
{
    Q_OBJECT
public:
    ReminderController(QObject *parent = 0);
    ~ReminderController();

    void initUI();

private:
    ReminderView *m_view;
    QSystemDeviceInfo *m_sysInfo;
};

#endif
