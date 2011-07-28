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
import "js/list.js" as List

Item {
    id: frmInput1
    //width: 360; height: 640
    property int upperBorder: 50
    width: parent.width; height: parent.height * 0.6
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    BorderImage {
        id: bkgItem
        width: 350; height: 375
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.top: parent.top
        anchors.topMargin: frmInput1.upperBorder
        anchors.left: frmInput1.left
        anchors.right: frmInput1.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

    }

    InputWidget {
        id: wdgName
        title: qsTr("Name")
        text: "Wine name here"
        anchors.top: bkgItem.top
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    function cleanup() {
        wdgName.text = "Wine name here"
        wdgColor.itemLabel = "red"
        wdgType.itemLabel = "Grape type e.g Merlot"
        wdgProducer.text = "Vineyard"
        wdgYear.text = "YYYY"
        wdgPrice.text = "$bucks"
    }

    function setter(storage) {
        wdgName.text = storage.name
        wdgColor.itemLabel = storage.type
        wdgType.itemLabel = storage.grape
        wdgProducer.text = storage.producer
        wdgYear.text = storage.year
        wdgPrice.text = "$" + storage.price
    }

    function getter(storage) {
        storage.name = wdgName.text;
        storage.type = wdgColor.itemLabel
        storage.grape = wdgType.itemLabel;
        storage.producer = wdgProducer.text
        storage.year = wdgYear.text

        var tmp = wdgPrice.text.indexOf("$")
        if (tmp != -1) {
            tmp = wdgPrice.text.substr(tmp + 1, wdgPrice.text.length)
        } else {
            tmp = wdgPrice.text
        }
        storage.price = tmp

    }

    InputWidget {
        id: wdgProducer
        title: qsTr("Producer")
        text: "Vineyard"
        anchors.top: wdgType.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgYear
        title: qsTr("Vintage Year")
        text: "YYYY"
        height: 50; width: 150
        anchors.top: wdgProducer.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

    InputWidget {
        id: wdgPrice
        title: qsTr("Price")
        text: "$bucks"
        height: 50; width: 150
        anchors.top: wdgProducer.bottom
        anchors.topMargin: 5
        anchors.right: bkgItem.right
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

    InputComboWidget {
        id: wdgType
        model: ModelGrape { id: m2 }
        title: qsTr("Kind of Wine")
        itemLabel: "Grape type e.g Merlot"
        height: 50; width: 250
        listHeight: parent.height * 0.8
        listWidth: 250
        anchors.top: wdgName.bottom
        anchors.topMargin: 5
        anchors.left: wdgColor.right
        anchors.leftMargin: -10
        anchors.right: bkgItem.right
    }


    InputComboWidget {
        id: wdgColor
        model: ModelWineColor { id: m1 }
        title: qsTr("Color")
        itemLabel: qsTr("wine color")
        height: 50; width: 120
        listHeight: 200
        listWidth: 250
        anchors.top: wdgName.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left

    }
}
