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

BorderImage {
    id: bkgItem
    signal clicked(int index, int id)
    signal pressAndHold(int index, int id, int x, int y)

    width: 306; height: parent.height
    border { left: 10; top: 10; right: 10; bottom: 10 }
    source: "imgs/main_item_bkg.png"

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    MouseArea {
        anchors.fill: parent
		hoverEnabled: true
        onClicked: bkgItem.clicked(index, model.id)
        onPressAndHold: bkgItem.pressAndHold(index, model.id, mouse.x, mouse.y)
    }

    function upperCase(text) {
        return text.toUpperCase(text)
    }

    function dynLength(text) {
        var result = 280

        if (text.length < 12) {
            result = text.length * 22
        }

        return result
    }

    function selectType(type) {

        //TODO: use a map for this
        var result;
        if (type == "Cabernet Sauvignon") {
            result = "imgs/cabernet_sauvignon.png"
        } else if (type == "Merlot") {
            result = "imgs/merlot.png"
        } else if (type == "Pinot Noir") {
            result = "imgs/pinot_noir.png"
        }

        return result;
    }

    Text {
        id: txtName
        text: name
        color: "#3E7E93"
        font { family: nsRegular.name; pixelSize: 22; }
        anchors.top: bkgItem.top
        anchors.topMargin: 7
        anchors.horizontalCenter: bkgItem.horizontalCenter
    }

    Image {
        id: imgBar
        source: "imgs/bar.png"
        anchors.top: txtName.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: txtName.horizontalCenter
    }

    Image {
        id: imgType
        source: selectType(grape)
        anchors.top: txtName.bottom
        anchors.topMargin: 12
        anchors.horizontalCenter: txtName.horizontalCenter
    }


    //TODO: move this 2 to a new widget file LabelType
    BorderImage {
        id: imgBackground
        source: "imgs/label.png"
        border { left: 15; top: 0; right: 15; bottom: 0 }
        anchors.top: imgType.bottom
        anchors.topMargin: 8
        anchors.horizontalCenter: imgType.horizontalCenter
        width: dynLength(grape)
    }

    Text {
        id: txtType
        text: grape
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 20; }
        anchors.horizontalCenter: imgBackground.horizontalCenter
        anchors.verticalCenter: imgBackground.verticalCenter
    }

    //.....................................................

    Text {
        id: txtProducer
        text: "<b>" + qsTr("Producer") + ": </b>"+ "<i>" + producer + "</i>"
        color: "#000000"
        font { family: nsRegular.name; pixelSize: 14; }
        anchors.top: txtType.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: txtType.horizontalCenter
    }

    Text {
        id: txtRegion
        text: "<b>" + qsTr("Region") + ": </b>" + "<i>" + region + "</i>"
        color: "#000000"
        font { family: nsRegular.name; pixelSize: 14; }
        anchors.top: txtProducer.bottom
        anchors.horizontalCenter: txtProducer.horizontalCenter
    }

    Text {
        id: txtYear
        text: year
        color: "#E5DBB8"
        font { family: nsRegular.name; pixelSize: 20; italic: true }
        anchors.top: txtRegion.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: txtRegion.horizontalCenter
    }

    //TODO: add a mouse area + click event
    Image {
        id: imgInfo
        source: "imgs/label_info.png"
        width: 290
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: bkgItem.horizontalCenter
        MouseArea {
            anchors.fill: parent
		    hoverEnabled: true
            onClicked: bkgItem.clicked(index, id)
        }

    }

}
