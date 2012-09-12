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
    id: overlay

    property variant currentModel : 10
    property variant currentCombo : ""
    property int currentModelIndex: 0

    signal comboBoxItemSelected()

    width: 100
    height: 100
    color: "#000"
    opacity:  0.0

    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.opacity = 0.0
            parent.focus = false
        }
    }

    Behavior on opacity {
        NumberAnimation { duration: 600 }
    }

    ListView {
        id: optionList

        property string selectedItem
        property double currentListHeight: optionList.count * 68 // 68 is the height of an item
        property double maxHeight: overlay.height * .8

        //FIXME: this must be a property parameter
        width: 360
        height: { currentListHeight > maxHeight ? maxHeight : currentListHeight }
        model: parent.currentModel
        anchors.fill: parent
        clip: true
        delegate: comboItem
        currentIndex: currentModelIndex
        highlight: Rectangle {
               //FIXME: this must be a property parameter
               color: "#697e85"
               Image {
                   width: 25; height: 21
                   source: "imgs/check_mark.png"
                   smooth: true
                   anchors.verticalCenter: parent.verticalCenter
                   anchors.right: parent.right; anchors.rightMargin: 15
               }
        }
        highlightMoveDuration: 0
        highlightMoveVelocity: -1
        focus: true
    }

    Component {
        id: comboItem
        ComboListItemComp {
            itemText: model.name ? model.name : ""
            onSelected: {
                optionList.selectedItem = model.value
                for (var i = 0; i < overlay.currentModel.count; i++) {
                    if(i == optionList.currentIndex) {
                        overlay.currentModel.setProperty(i, "selected", true)
                        overlay.currentModelIndex = i
                    } else {
                        overlay.currentModel.setProperty(i, "selected", false)
                    }
                }
                currentCombo.itemLabel = model.name
                overlay.opacity = 0.0
                comboBoxItemSelected()
            }
        }
    }

    Rectangle {
        width: optionList.width; height: 2
        //FIXME: this must be a property parameter
        color: "#FFFFFF"
        anchors.horizontalCenter: optionList.horizontalCenter
        anchors.top: optionList.top
        anchors.topMargin: 2
    }

    Rectangle {
        width: optionList.width; height: 2
        //FIXME: this must be a property parameter
        color: "#FFFFFF"
        anchors.horizontalCenter: optionList.horizontalCenter
        anchors.bottom: optionList.bottom
        anchors.bottomMargin: 2
    }
}
