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

Item {
    id: wdgParent
    width: 100
    height: 40

    property string label: qsTr("Red")
    signal enabled();
    signal disabled();

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            if (wdgParent.state == "disabled") {
                wdgParent.state = "enabled";
                wdgParent.enabled();
            } else {
                wdgParent.state = "disabled";
                wdgParent.disabled();
            }
        }
    }

    Rectangle {
        id: wdgRect
        width: 35
        height: 35
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 5
        smooth: true
    }

    Image {
        id: imgCheck
        source: "imgs/check_mark.png"
        smooth: true
        width: 39; height: 39
        anchors.left: wdgRect.left
        anchors.top: wdgRect.top
        anchors.bottom: wdgRect.bottom
    }

    Text {
        id: txtCheck
        text: wdgParent.label
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 22 }
        anchors.left: wdgRect.right
        anchors.leftMargin: 10
        anchors.top: wdgRect.top
        anchors.topMargin: 5

    }

    state: "enabled"
    states: [
        State {
            name: "enabled"
            PropertyChanges {
                target: imgCheck
                visible: true
            }

        },

        State {
            name: "disabled"
            PropertyChanges {
                target: imgCheck
                visible: false
            }
        }
    ]

    //TODO: fade transition on check state change

}

