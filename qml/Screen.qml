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

Frame {
    id: frmScreen

    property alias upperBar: imgBarup
    property alias lowerBar: imgBarlower

    Image {
        id: imgBarup
        width: parent.width; height: 62
        anchors.top: frmScreen.top
        anchors.left: frmScreen.left
        anchors.right: frmScreen.right
        fillMode: Image.Tile
        source: "imgs/main_top_bar.png"
    }

    Image {
        id: imgBarlower
        width: parent.width; height: 60
        anchors.bottom: frmScreen.bottom
        anchors.left: frmScreen.left
        anchors.right: frmScreen.right
        fillMode: Image.TileHorizontally
        source: "imgs/main_low_bar.png"
    }

}
