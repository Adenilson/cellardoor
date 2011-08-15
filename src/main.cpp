/*  Copyright (C) 2011  Adenilson Cavalcanti <cavalcantii@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; by version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

#include <QtGui/QApplication>
#include <QtGui/QMessageBox>
#include <QtCore/QLocale>
#include <QtCore/QTranslator>
#include <QDebug>
#include "adpcppf.h"
#include "controller.h"
#include "utils.h"

static const char s_applicationName[] = "cellardoor";
static const char s_applicationVersion[] = "0.51";

bool isAuthorized()
{
#ifdef QT_DEBUG
    // Do not check authorization for debug version
    return true;
#endif

    bool authorized = false;

    QString message;

    com::intel::adp::Application *pApp = NULL;

    try
    {
        pApp = new Application(ADP_DEBUG_APPLICATIONID);

        // Authorized successfully
        authorized = true;
    }
    catch (com::intel::adp::AdpException& e)
    {
        // Got some error
        message = QString::fromAscii(e.message());
    }

    if(pApp != NULL)
    {
        delete pApp;
    }

    if(authorized == false)
    {
        QMessageBox msgBox(QMessageBox::Information, "cellardoor", message, QMessageBox::Ok);
        msgBox.exec();
    }

    return authorized;
}

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    //QApplication::setGraphicsSystem("opengl");
    app.setApplicationName(s_applicationName);
    app.setApplicationVersion(s_applicationVersion);

    if (!isAuthorized()) {
      app.quit();
      return 0;
    }

    const QString locale = QLocale::system().name();
    QTranslator translator;
    translator.load(app.applicationName() + "_" + locale);
    app.installTranslator(&translator);

    CellarController controller(0, &app);
    controller.initUI();
    Utils::setOrientation(Utils::PORTRAIT);

    return app.exec();;
}
