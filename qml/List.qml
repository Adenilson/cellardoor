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

import QtQuick 2.0

ListView {
    id: lstOss
    width: parent.width
    signal listClicked(int index, int id)
    signal listPressAndHold(int id, int x, int y)

    orientation: ListView.Horizontal

    //model: Model { id: myModel }
    model: WineModel
    delegate: Delegate {
        id: myDelegate
        onClicked: lstOss.listClicked(index, id)
        onPressAndHold:  {
            var obj = myDelegate.mapToItem(lstOss, x, y)
            lstOss.listPressAndHold(id, obj.x, obj.y)
        }

    }

    anchors.bottom: parent.bottom
    spacing: 30
}
