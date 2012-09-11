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
    id: window
    width: 360; height: 100
    property alias title: wdgCombo.title
    property alias itemLabel: wdgCombo.itemLabel
    property alias listWidth: wdgList.width
    property alias listHeight: wdgList.height
    property alias model: wdgList.currentModel
    property alias value: wdgCombo.itemLabel

    InputCombo {
        id: wdgCombo
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        title: "Connect with"
        itemLabel: "3G+WiFi"
        onClick: {
            wdgList.currentCombo = wdgCombo
            wdgList.currentModelIndex = currentComboIndex
            wdgList.visible = true
            wdgList.opacity = .8
        }
    }

    ComboListComp {
        id: wdgList
        width: 150
        height: 300
        visible: false
        onComboBoxItemSelected: {
            console.log("# Selected..." + currentModelIndex)
            console.log(".... " +
            wdgList.currentModel.get(currentModelIndex).name)
        }
    }

}
