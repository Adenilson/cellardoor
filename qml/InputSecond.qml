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
    id: frmInput
    //width: 360; height: 640
    property int upperBorder: 50
    width: parent.width; height: parent.height * 0.6
	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    BorderImage {
        id: bkgItem
        width: 350; height: 375
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.top: parent.top
        anchors.topMargin: frmInput.upperBorder
        anchors.left: frmInput.left
        anchors.right: frmInput.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

    }

    InputWidget {
        id: wdgTaste
        title: qsTr("Tasting comments")
        text: "How it tastes here"
        anchors.top: bkgItem.top
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    function cleanup() {
        wdgTaste.text = "How it tastes here"
        wdgComparison.text = "How it compare"
        wdgWhere.text = "Your current location"
        wdgWhen.date = "DD-MM-YY"
        wdgRate.text = "1 to 5"
    }

    function setter(storage) {
        wdgTaste.text = storage.tasting
        wdgComparison.text = storage.comparison
        wdgWhere.text = storage.location
        wdgWhen.date = storage.date
        wdgRate.text = storage.rate
    }

    function getter(storage) {
        storage.tasting = wdgTaste.text;
        storage.comparison = wdgComparison.text;
        storage.location = wdgWhere.text
        storage.date = wdgWhen.date
        storage.rate = wdgRate.text
    }

    InputWidget {
        id: wdgComparison
        title: qsTr("Comparisons")
        text: "How it compare"
        anchors.top: wdgTaste.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgWhere
        title: qsTr("Place")
        text: "Your current location"
        anchors.top: wdgComparison.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgRate
        title: qsTr("Rating")
        text: "1 to 5"
        height: 50; width: 150
        anchors.top: wdgWhere.bottom
        anchors.topMargin: 5
        anchors.right: bkgItem.right
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

    InputCalendar {
        id: wdgWhen
        title: qsTr("Date consumed")
        date: "DD-MM-YY"
        height: 50; width: 150
        anchors.top: wdgWhere.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }


}
