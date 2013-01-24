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

Item {
    width: parent.width; height: parent.height
    property string text: ""
    property alias textColor: txtOption.color
    property alias font: txtOption.font
    signal clicked()

    Text {
        id: txtOption
    	text: parent.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
