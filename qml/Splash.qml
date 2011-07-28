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

Frame {
    id: frmSplash
    signal hideDone()

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Effect {
        id: objPlayer
    }

    BorderImage {
        id: imgBar
        width: parent.width; height: 294
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        y: 85
        border { left: 0; top: 0; right: 0; bottom: 0 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_bluebar.png"
        Behavior on y {
            NumberAnimation {
                duration: 200;
                onRunningChanged: {
                    if (!running)
                    frmSplash.hideDone()
                }
            }
        }

        states: [

            State {
                name: "hidden"
                PropertyChanges {
                    target: imgBar
                    y: -height
                }

            },

            State {
                name: "show"
                PropertyChanges {
                    target: imgBar
                    y: 85
                }

            }
        ]

    }

    function hideSplash() {
        hideAnimated()
        objPlayer.play()
    }

    onAnimationCompleted: imgBar.state = "hidden"

    Text {
        id: txtWelcome
        text: qsTr("Welcome to")
    	color: "#FFFFFF"
	    font { family: vgRounded.name; pixelSize: 21; italic: true }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.top: imgBar.top
        anchors.topMargin: 50
    }

    Image {
        id: imgLine
        anchors.top: txtWelcome.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: txtWelcome.horizontalCenter
        source: "imgs/line_break.png"
    }


    Text {
        id: txtAppname
        text: "CellarDoor"
    	color: "#FFFFFF"
	    font { family: nsRegular.name; pixelSize: 42; }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.verticalCenter: imgBar.verticalCenter
        anchors.top: txtWelcome.bottom
        anchors.topMargin: 30
    }

    Image {
        id: imgLine2
        anchors.top: txtAppname.bottom
        anchors.topMargin: -30
        anchors.horizontalCenter: txtAppname.horizontalCenter
        source: "imgs/line_break.png"
    }


    Text {
        id: txtWelcome2
        text: qsTr("your personal wine journal")
    	color: "#FFFFFF"
	    font { family: vgRounded.name; pixelSize: 21; italic: true }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.top: imgBar.bottom
        anchors.topMargin: -100
    }

}
