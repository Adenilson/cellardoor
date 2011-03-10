#ifndef __REMINDERVIEW_H__
#define __REMINDERVIEW_H__

#include <QtCore/QObject>

#include <QtDeclarative/QDeclarativeView>

class QDeclarativeContext;

class ReminderView : public QDeclarativeView
{
    Q_OBJECT
public:
    ReminderView(QWidget *parent = 0);
    ~ReminderView();

private Q_SLOTS:
    void onStatusChanged(QDeclarativeView::Status status);
    bool event(QEvent *event);

private:
    QDeclarativeContext *m_context;
};

#endif
