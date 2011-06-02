#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include <QSystemDeviceInfo>

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

protected slots:
    void updateStorage(const QString &key, const QVariant &value);

private:
    CellarView *m_view;
    QSystemDeviceInfo *m_sysInfo;
    QDeclarativePropertyMap *m_map;
};

#endif
