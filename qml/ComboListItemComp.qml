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

Rectangle {
    id: comboListItem
    property string itemText: "Label"

    signal selected()

    width: parent.width
    color: "transparent"
    height: label.paintedHeight + 38

    Text {
        id: label
        width: parent.width - 30

        text: itemText
        font.family: "Nokia Standard"
        font.weight: "Bold"
        color: "#FFF"
        font.capitalization: Font.Capitalize
        font.pixelSize:  24
        wrapMode:  Text.WordWrap

        clip: true

        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin: 8;
        anchors.bottomMargin: 10
        anchors.right: parent.right; anchors.rightMargin: 65
        anchors.left: parent.left; anchors.leftMargin: 15
    }
    MouseArea {
        anchors.fill: parent
        onClicked:  {
            optionList.currentIndex = index
            selected()
        }
        onPressed: {
            comboListItem.color = "#F0BEBEBE"
        }

        onReleased: {
            comboListItem.color = "transparent"
        }
    }
    Behavior on color {
        ColorAnimation {
            duration: 50;
        }
    }
}
