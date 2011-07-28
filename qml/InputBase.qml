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

Item {
    id: wdgInput
    property alias title: txtTitle.text
    property alias txtTitle: txtTitle
    property alias imgBackground: imgBackground

    width: 400; height: 90

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Text {
        id: txtTitle
        text: "Name"
        color: "#CA893B"
        font { family: nsRegular.name; pixelSize: 16; italic: true }
        anchors.left: wdgInput.left
        anchors.leftMargin: 20
        anchors.top: wdgInput.top
    }


    BorderImage {
        id: imgBackground
        border { left: 10; top: 10; right: 10; bottom: 10 }
        anchors.top: txtTitle.bottom
        anchors.topMargin: 5
        anchors.left: wdgInput.left
        anchors.leftMargin: 10
        anchors.right: wdgInput.right
        anchors.rightMargin: 10
        source: "imgs/edit_bkg.png"
    }

}
