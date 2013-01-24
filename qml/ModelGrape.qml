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

import QtQuick 1.1

ListModel {
    id: mdlWine
    //TODO: how to handle translations?
    ListElement { name: "Merlot"; value: 1; selected: true }
    ListElement { name: "Cabernet Sauvignon"; value: 2; selected: false }
    ListElement { name: "Cabernet Sauvignon Blanc"; value: 3; selected: false }
    ListElement { name: "Pinot Noir"; value: 4; selected: false }
    ListElement { name: "Port"; value: 5; selected: false }
    ListElement { name: "Multi"; value: 6; selected: false }
    ListElement { name: "Chiraz"; value: 7; selected: false }
    ListElement { name: "Malbec"; value: 8; selected: false }
    ListElement { name: "Chardornay"; value: 9; selected: false }
    ListElement { name: "Riesling"; value: 10; selected: false }
    ListElement { name: "Other"; value: 11; selected: false }
}
