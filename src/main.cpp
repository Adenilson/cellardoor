#include <QtGui/QApplication>
#include "controller.h"
#include "utils.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //QApplication::setGraphicsSystem("opengl");

    ReminderController controller;
    controller.initUI();
    Utils::setOrientation(Utils::PORTRAIT);

    return app.exec();;
}
