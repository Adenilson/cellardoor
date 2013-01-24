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

InputBase {
    id: wdgCalendarInput

    property alias date: txtDescription.text
    title: "Date"

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Text {
        id: txtDescription
        text: "Description"
        color: "#385661"
        elide: Text.ElideRight
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.left: txtTitle.left
        anchors.right: imgBackground.right
        anchors.verticalCenter: imgBackground.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (wdgCalendar.opacity == 0.8) {
                    wdgCalendar.height = 0
                    wdgCalendar.opacity = 0.0
                } else {
                    wdgCalendar.opacity = 0.8
                    wdgCalendar.height = 386
                }
            }
        }
    }

    Calendar {
        id: wdgCalendar
        anchors.bottom: imgBackground.bottom
        anchors.bottomMargin: -25
        anchors.left: imgBackground.left
        anchors.leftMargin: -5
        height: 0
        opacity: 0.0
        onClicked: {
            txtDescription.text = wdgCalendar.clickedDate
            wdgCalendar.opacity = 0.0
            wdgCalendar.height = 0
        }

        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }

        Behavior on height {
            NumberAnimation { duration: 300 }
        }
    }
}
