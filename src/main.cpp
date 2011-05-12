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

    const QString locale = QLocale::system().name();
    QTranslator translator;
    translator.load(app.applicationName() + "_" + locale);
    app.installTranslator(&translator);

    CellarController controller;
    controller.initUI();
    Utils::setOrientation(Utils::PORTRAIT);

    return app.exec();;
}
