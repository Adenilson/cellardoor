#include <QtGui/QApplication>
#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QDebug>
#include "controller.h"
#include "utils.h"

static char *s_applicationName = "celladoor";

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //QApplication::setGraphicsSystem("opengl");
    app.setApplicationName(s_applicationName);

    QString locale = QLocale::system().name();
    QTranslator translator;
    //XXX: HACK
#ifdef Q_OS_SYMBIAN
    translator.load(app.applicationName() + "_" + QLocale::system().name());
#else
    translator.load("translations/" + app.applicationName() + "_" + QLocale::system().name());
#endif
    app.installTranslator(&translator);

    ReminderController controller;
    controller.initUI();
    Utils::setOrientation(Utils::PORTRAIT);

    return app.exec();;
}
