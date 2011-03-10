#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
class ReminderView;

class ReminderController : public QObject
{
    Q_OBJECT
public:
    ReminderController(QObject *parent = 0);
    ~ReminderController();

    void initUI();

private:
    ReminderView *m_view;
};

#endif
