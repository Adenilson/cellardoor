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

import Qt 4.7

BorderImage {
    id: wdgSubmenu
    width: 100; height: 100
    border { left: 10; top: 0; right: 10; bottom: 0 }
    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Stretch
    source: "imgs/list_bg.png"

    signal editOption();
    signal deleteOption();

    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    TextButton {
        id: edit
        width: parent.width
        height: parent.height / 2
        text: qsTr("Edit")
        textColor: "#5a4f3d"
        font { family: nsRegular.name; pixelSize: 20 }
        anchors.top: parent.top
        anchors.left: parent.left
        onClicked: wdgSubmenu.editOption()
    }

    TextButton {
        id: deleteElemt
        width: parent.width
        height: parent.height / 2
        text: qsTr("Delete")
        textColor: "#5a4f3d"
        font { family: nsRegular.name; pixelSize: 20 }
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        onClicked: wdgSubmenu.deleteOption()
    }
}
