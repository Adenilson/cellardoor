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

Item {
    id: wdgCamera
    //height: 400; width: 300
    width: parent.width; height: parent.height * 0.6
    property int upperBorder: 50
    property int margin: 5
    property bool working: camera.working
    property string picture
    signal snaped()

    function stop() {
        camera.stop()
    }

    function start() {
        camera.start()
    }

    BorderImage {
        id: bkgItem
        width: 350; height: 375
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.top: parent.top
        anchors.topMargin: wdgCamera.upperBorder
        anchors.left: wdgCamera.left
        anchors.right: wdgCamera.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

    }

    CameraScreen {
        id: camera
        anchors.top: bkgItem.top
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
        anchors.bottom: bkgItem.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        Component.onCompleted: snaped.connect(wdgCamera.snaped)
        onSnaped: wdgPicture.source = camera.picture
    }

    Image {
        id: wdgPicture
        height: 59
        width: 83
        anchors.left: bkgItem.left
        anchors.bottom: bkgItem.top
        anchors.leftMargin: 6
        anchors.bottomMargin: -62
    }

}
