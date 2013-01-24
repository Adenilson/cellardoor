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

Rectangle {
    id: item

    property string itemText: "Title"
    property string itemLabel: "1"
    property double itemWidth: 480
    property bool clicked: false
    property int currentComboIndex: 0

    signal click()

    width: itemWidth
    height: label.paintedHeight + 38
    color: "#FFF"

    Behavior on color {
        ColorAnimation { duration: 100 }
    }

    Text {
        id: label
        width: itemWidth - 30

        text: itemText
        font.family: "Nokia Standard"
        font.weight: "Bold"
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

    Rectangle {
        color: "#000"
        width: labelText.paintedWidth + 25
        height: labelText.paintedHeight + 15
        radius: 15

        Text {
            id: labelText
            text: itemLabel

            font.family: "Nokia Standard"
            font.weight: "Bold"
            font.capitalization: Font.Capitalize
            font.pixelSize:  16
            anchors.centerIn: parent
            color: "#FFF"
        }
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right; anchors.rightMargin: 10
    }

    MouseArea {
        anchors.fill: parent
        onClicked: click()

        onPressed: {
            item.color = "#CCC"
        }
        onReleased: {
            item.color = "#FFF"
        }
    }
}
