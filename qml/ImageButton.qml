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
    id: button
    property string current: "imgs/textbutton.png"
    property string background: "imgs/textbutton.png"
    property string pressed: "imgs/textbutton_pressed.png"
    property string focused: "imgs/textbutton_focused.png"
    signal buttonClicked
    width: background.width; height: background.height

    Image {
        id: background
        source: button.current
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        signal buttonClicked

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onPressed: button.current = button.pressed
            onClicked: {
                button.current = button.background
                button.buttonClicked()
            }
            onEntered: button.current = button.focused
            onExited: button.current = button.background
        }

    }
}
