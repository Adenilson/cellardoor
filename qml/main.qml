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
import "js/viewcreate.js" as Factory

Item {
    id: appWindow
    width: 362; height: 642
    property variant controller: Controller
    Connections {
        id: cncTranslate
        onLanguageChange: {
            if (controller == undefined) {
                console.log("### Sorry, I have no real Controller " +
                "object. Can't load new language.");
                return
            }

            controller.changeLanguage(language)
            ldlView.source = ""
            ldlView.source = "View.qml"
        }
    }

    Splash {
        id: wdgSplash
        onHideDone: ldlView.source = "View.qml"
    }

    // FIXME: for some reason, in Qt5 the Factory is borked
    Loader {
        id: ldlView
        onLoaded: {
            cncTranslate.target = ldlView.item
            ldlView.item.parent = appWindow
            ldlView.item.anchors.fill = parent
        }
    }

    Timer {
        id: tmDelay
        interval: 1000; running: false; repeat: false;
        onTriggered: wdgSplash.hideSplash()
    }

    Component.onCompleted: tmDelay.running = true
}
