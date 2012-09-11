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
    id: button
    property bool isCurrentDay: false
    property string day: "ouch!"
    property bool currentMonth: true
    property bool currentDay: false
    property alias current: background.source

    property string background: button.currentDay ? "imgs/calendar_day_current.png" : "imgs/calendar_day_unset.png"
    property string pressed: "imgs/calendar_day_to_set.png"
    signal buttonClicked(int index)
    width: background.width; height: background.height

    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    //FIXME: fails to execute
    function reset() {
        label.reset()
        button.current = button.background
    }

    Image {
        id: background
        source: button.background
        property bool visited: false
        signal buttonClicked

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                if (!background.visited) {
                    background.source = button.pressed
                    label.selected()
                } else {
                    background.source = button.background
                    label.reset()
                }

                background.visited = !background.visited;

                button.buttonClicked(index)
            }

            onCanceled: background.current = button.background
        }
    }

    Text {
        id: label
        text: button.day
        font { family: nsRegular.name; pixelSize: 22 }
        color: currentMonth ? "#697e85" : "#9bb6bf"
        anchors.verticalCenter: background.verticalCenter
        anchors.horizontalCenter: background.horizontalCenter

        function reset() {
            label.color = currentMonth ? "#697e85" : "#9bb6bf"
        }

        function selected() {
            label.color = "#FFFFFF"
        }
    }
}

