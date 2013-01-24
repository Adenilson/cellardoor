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
    width: 339; height: 66
    id: monthHandler
    property string calendarString: ""
    signal previousClicked()
    signal nextClicked()

    //TODO: must be Nokia Sans Semibold
    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    ImageButton {
        id: prevBtn
        current: "imgs/btn_prev.png"
        background: "imgs/btn_prev.png"
        pressed: "imgs/btn_prev_pressed.png"
        focused: "imgs/btn_prev.png"
        anchors.left: parent.left
        anchors.leftMargin: -2
        onButtonClicked: monthHandler.previousClicked()
    }

    Image {
        id: calendarStringImg
        source: "imgs/calendar_string_bg.png"
        height: 66; width: 211
        fillMode: Image.Tile
        anchors.left: prevBtn.right
    }

    Text {
        text: calendarString
        font { family: nsRegular.name; pixelSize: 24 }
        color: "#5b5b5b"
        anchors.verticalCenter: calendarStringImg.verticalCenter
        anchors.horizontalCenter: calendarStringImg.horizontalCenter

    }

    ImageButton {
        id: nextBtn
        current: "imgs/btn_next.png"
        background: "imgs/btn_next.png"
        pressed: "imgs/btn_next_pressed.png"
        focused: "imgs/btn_next.png"
        anchors.left: calendarStringImg.right
        onButtonClicked: monthHandler.nextClicked()
    }

}
