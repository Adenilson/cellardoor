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


#ifndef _REMINDER_CONTROLLER_H_
#define _REMINDER_CONTROLLER_H_

#include <QtCore/QObject>
#include "genericmodel.h"
#include "wine.h"
#include "database.h"

class QDeclarativePropertyMap;
class CellarView;
class QApplication;

class CellarController : public QObject
{
    Q_OBJECT
public:
    CellarController(QObject *parent = 0, QApplication *application = 0);
    ~CellarController();

    void initUI();

public slots:
    void editWine(int id);
    void fillStorage(int id);
    void deleteWine(int id);
    int wineCount();
    void createNewWine();

    void quit();
    QString workingDir();
    int system();

    void filter(const int &state);

protected slots:
    void updateStorage(const QString &key, const QVariant &value);
    void setScreen(int orientation = 2);

protected:
    void fillStorageProperties();
    void setupFilterStates();

private:
    QApplication *m_app;
    CellarView *m_view;
    QDeclarativePropertyMap *m_map;
    GenericModel<WineData> *m_modelWine;
    Database<WineData> *m_database;
};

#endif
