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
    property string labelText: "ouch!"
    property string current: "imgs/textbutton.png"
    property string background: "imgs/textbutton.png"
    property string pressed: "imgs/textbutton_pressed.png"
    property string focused: "imgs/textbutton_focused.png"
    signal buttonClicked
    width: 82
    height: 78
    property alias imgWidth: background.width
    property alias imgHeight: background.height
    property alias txtColor: label.color
    property int txtSize: 16

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

    Text {
        id: label
        text: button.labelText
        color: "#352d2a"
        font { pixelSize: button.txtSize }
        anchors.horizontalCenter: background.horizontalCenter
        anchors.verticalCenter: background.verticalCenter
        //anchors.topMargin: 2
    }
}
