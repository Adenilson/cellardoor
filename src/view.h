#ifndef __REMINDERVIEW_H__
#define __REMINDERVIEW_H__

#include <QtCore/QObject>

#include <QtDeclarative/QDeclarativeView>

class QDeclarativeContext;

class CellarView : public QDeclarativeView
{
    Q_OBJECT
public:
    CellarView(QWidget *parent = 0);
    ~CellarView();

private Q_SLOTS:
    void onStatusChanged(QDeclarativeView::Status status);
    bool event(QEvent *event);

private:
    QDeclarativeContext *m_context;
};

#endif
