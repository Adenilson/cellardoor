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
    id: background
    //This will block any x/y animation
    //anchors.fill: parent
    width: parent.width; height: parent.height
    signal animationCompleted


    BorderImage {
        id: toolbar1
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: 0
        border { left: 0; top: 0; right: 0; bottom: 0 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

    }

    BorderImage {
        id: toolbar2
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: parent.width / 2
        border { left: 0; top: 0; right: 0; bottom: 0 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

    }

    ParallelAnimation {
        id: animSlide
        NumberAnimation { target: toolbar1; property: "x";
                          to: -toolbar1.width; duration: 700 }
        NumberAnimation { target: toolbar2; property: "x";
                          to: toolbar2.x + toolbar2.width; duration: 700 }

        onRunningChanged: if (!running) background.animationCompleted()

    }

    function hideAnimated() {
        animSlide.running = true
    }

}
