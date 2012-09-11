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

InputBase {
    id: wdgCombo

    title: "Combo"
    property string itemLabel: "Title"
    property int currentComboIndex: 0

    signal click()

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Text {
        id: txtDescription
        text: wdgCombo.itemLabel
        color: "#385661"
        elide: Text.ElideRight
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.left: txtTitle.left
        anchors.right: imgBackground.right
        anchors.verticalCenter: imgBackground.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: click()

            onPressed: {
                wdgCombo.opacity = 0.70
            }
            onReleased: {
                wdgCombo.opacity = 1.0
            }

        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: click()

        onPressed: {
            wdgCombo.opacity = 0.70
        }
        onReleased: {
            wdgCombo.opacity = 1.0
        }
    }


}
