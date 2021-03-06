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
import "js/list.js" as List

Screen {
    id: frmInput1
    //width: 360; height: 640
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }
    signal finish();
    signal cancel();

    lowerBar.height: 80

    function cleanup() {
        wdgFirst.cleanup()
        wdgSecond.item.cleanup()
    }

    function setter(storage) {
        wdgFirst.setter(storage)
        wdgSecond.item.setter(storage)
    }

    function getter(storage) {
        wdgFirst.getter(storage)
        wdgSecond.item.getter(storage)
    }

    Text {
        id: txtCellar
        text: "CellaDoor"
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.horizontalCenter: upperBar.horizontalCenter
    }

    Text {
        id: txtCancel
        text: qsTr("Cancel")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.right: upperBar.right
        anchors.rightMargin: 3
        MouseArea {
            anchors.fill: parent
            onPressed: {
                frmInput1.cancel()
                frmInput1.state = "first"
                wdgThird.item.stop()
            }
        }

    }

    Text {
        id: txtBack
        text: qsTr("Back")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.left: upperBar.left
        anchors.leftMargin: 3
        MouseArea {
            anchors.fill: parent
            onPressed: {
                if (frmInput1.state == "first") {
                    return;
                } else if (frmInput1.state == "second") {
                    frmInput1.state = "first"
                } else {
                    wdgThird.item.stop()
                    frmInput1.state = "second"
                }
            }
        }

    }

    Text {
        id: txtAdding
        text: qsTr("Adding a new wine to your Cellar")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 18; italic: true }
        anchors.top: upperBar.bottom
        anchors.topMargin: 3
        anchors.horizontalCenter: upperBar.horizontalCenter
    }

    Image {
        id: imgLine
        anchors.top: txtAdding.bottom
        anchors.topMargin: 3
        anchors.horizontalCenter: upperBar.horizontalCenter
        source: "imgs/line_break.png"
    }


    Text {
        id: txtSteps
        text: qsTr("Step 1")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.top: imgLine.bottom
        anchors.horizontalCenter: imgLine.horizontalCenter
    }


    InputOne {
        id: wdgFirst
        //A tad verbose but better than hardcoded
        upperBorder: (lowerBar.height + txtAdding.height +
        imgLine.height + txtSteps.height) * 0.92
        visible: true
    }

    Loader {
        id: wdgSecond
        onLoaded: {
            wdgSecond.item.upperBorder = (lowerBar.height +
            txtAdding.height + imgLine.height + txtSteps.height) * 0.92
            wdgSecond.item.parent = frmInput1
            wdgSecond.item.visible = false
            console.log("wdgSecond: loaded.")
        }
    }

    Loader {
        id: wdgThird
        onLoaded: {
            wdgThird.item.upperBorder = (lowerBar.height +
            txtAdding.height + imgLine.height + txtSteps.height) * 0.92
            wdgThird.item.parent = frmInput1
            wdgThird.item.visible = false
            console.log("wdgThird: loaded.")
        }
    }

/*
    CameraWidget {
        id: wdgThird
        upperBorder: (lowerBar.height + txtAdding.height +
        imgLine.height + txtSteps.height) * 0.92
        onSnaped: console.log("#### I got an image!")
        visible: false
    }
*/
    Button {
        id: btnOk
        imgHeight: 58; imgWidth: 200
        txtSize: 26
        labelText: qsTr("Next")
        txtColor: "#FFFFFF"
        current: "imgs/button_bkg.png"
        background: "imgs/button_bkg.png"
        pressed: "imgs/button_bkg.png"
        focused: "imgs/button_bkg.png"
        anchors.bottom: lowerBar.bottom
        anchors.horizontalCenter: lowerBar.horizontalCenter
        onButtonClicked: {
	        if (frmInput1.state == "third") {
                wdgThird.item.stop()
                frmInput1.finish()
                frmInput1.state = "first"
            } else if (frmInput1.state == "second") {
                if (wdgThird.progress == 0.0) {
                    console.log("Create third!")
                    wdgThird.source = "CameraWidget.qml"
                }
                frmInput1.state = "third"
                wdgThird.item.start()
            } else if (frmInput1.state == "first") {
                if (wdgSecond.source == 0.0) {
                    console.log("Create second!")
                    wdgSecond.source = "InputSecond.qml"
                }
                frmInput1.state = "second"
            }
        }

    }

    state: "first"
    states: [
        State {
            name: "first"
            PropertyChanges {
                target: wdgFirst
                visible: true
            }

            PropertyChanges {
                target: wdgSecond.item
                visible: false
            }

            PropertyChanges {
                target: wdgThird.item
                visible: false
            }

            PropertyChanges {
                target: btnOk
                labelText: qsTr("Next")
            }

            PropertyChanges {
                target: txtSteps
                text: qsTr("Step 1")
            }

        },

        State {
            name: "second"
            PropertyChanges {
                target: wdgFirst
                visible: false
            }

            PropertyChanges {
                target: wdgSecond.item
                visible: true
            }

            PropertyChanges {
                target: wdgThird.item
                visible: false
            }

            PropertyChanges {
                target: btnOk
                labelText: qsTr("Next")
            }

            PropertyChanges {
                target: txtSteps
                text: qsTr("Step 2")
            }

        },

        State {
            name: "third"
            PropertyChanges {
                target: wdgFirst
                visible: false
            }

            PropertyChanges {
                target: wdgSecond.item
                visible: false
            }

            PropertyChanges {
                target: wdgThird.item
                visible: true
            }

            PropertyChanges {
                target: btnOk
                labelText: qsTr("Finish")
            }

            PropertyChanges {
                target: txtSteps
                text: qsTr("Step 3")
            }

        }
    ]

}
