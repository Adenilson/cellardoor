#include <QtGui/QApplication>
#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QDebug>
#include "controller.h"
#include "utils.h"

static char *s_applicationName = "celladoor";
static const char *s_applicationVersion = "0.50";

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //QApplication::setGraphicsSystem("opengl");
    app.setApplicationName(s_applicationName);
    app.setApplicationVersion(s_applicationVersion);

    const QString locale = QLocale::system().name();
    QTranslator translator;
    translator.load(app.applicationName() + "_" + locale);
    app.installTranslator(&translator);

    CellarController controller;
    controller.initUI();
    Utils::setOrientation(Utils::PORTRAIT);

    return app.exec();;
}
