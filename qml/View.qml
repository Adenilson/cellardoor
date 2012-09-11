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
import "js/list.js" as List

Screen {
    id: frmSplash
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    //width: 360; height: 640
    lowerBar.height: 65
    property int selectedId: 0
    property bool editing: false
    signal languageChange(string language)

    Image {
        id: imgBarmiddle
        width: parent.width
        height: 155
        anchors.bottom: lowerBar.top
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.TileHorizontally
        source: "imgs/main_middle_bar.png"
    }

    CheckBar {
        id: chkBar
        anchors.top: imgBarmiddle.top
        anchors.left: imgBarmiddle.left
        anchors.right: imgBarmiddle.right
        onFilter: {
            Controller.filter(state)
            txtPosition.updateLabel(0)
        }
    }

    Text {
        id: txtCellar
        text: "CellarDoor"
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.horizontalCenter: upperBar.horizontalCenter
    }

    Text {
        id: txtTranslate
        text: qsTr("Lang")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.left: upperBar.left
        anchors.leftMargin: 15
        MouseArea {
            anchors.fill: parent
            onPressed: wdgLanguage.visible = !wdgLanguage.visible //TODO: animate
        }
    }

    Text {
        id: txtExit
        text: qsTr("Exit")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.right: upperBar.right
        anchors.rightMargin: 15
        MouseArea {
            anchors.fill: parent
            onPressed: Qt.quit()
        }

    }

    Text {
        id: txtPosition
        text: lstWine.currentIndex + 1 + " / " + Controller.wineCount()
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 22; italic: true }
        anchors.top: upperBar.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: upperBar.horizontalCenter
        function updateLabel(index) {
            //BUG: currentIndex returns the same value
            //txtPosition.text = lstWine.currentIndex + 1 + " / " + Controller.wineCount();
            if (index != -1) {
                if (Controller.wineCount() > 0) {
                    txtPosition.text = index + 1 + " / " +
                    Controller.wineCount();
                } else {
                    txtPosition.text = "0 / 0"
                }
            } else {
                txtPosition.text = "0 / 0"
            }
        }
    }


    List {
        id: lstWine
        anchors.top: upperBar.bottom
        anchors.topMargin: 40
        anchors.left: upperBar.left
        anchors.leftMargin: 30
        anchors.right: upperBar.right
        anchors.rightMargin: 30
        anchors.bottom: lowerBar.top
        anchors.bottomMargin: 165

        onListClicked: {
            if (wdgSubmenu.visible) {
                wdgSubmenu.visible = false
            }
            console.log("###### clicked: " + index);
            txtPosition.updateLabel(index);
            //TODO: show detailed view
        }

        onListPressAndHold: {
            console.log("########x: " + x + "\ty: " + y + "\tid: " + id)
            var delta = 30
            frmSplash.selectedId = id
            wdgSubmenu.x = x - delta; wdgSubmenu.y = y - delta;
            wdgSubmenu.visible = true
        }

        //BUG: currentIndex returns the same value
        //onFlickEnded: txtPosition.updateLabel()
        //onFlickStarted: txtPosition.updateLabel()
    }

    Loader {
        id: ldlInput
        property variant data: null
        onLoaded: {
            ldlInput.item.parent = frmSplash
            ldlInput.item.anchors.fill = frmSplash
            ldlInput.item.finish.connect(frmSplash.processInput)
            ldlInput.item.cancel.connect(frmSplash.cancel)
            setter(data)
        }

        function setter(data) {
            ldlInput.item.setter(data)
        }
    }

    // FIXME: for some reason, in Qt5 the Factory is borked
    Submenu {
        id: wdgSubmenu
        visible: false
        onEditOption: {
            wdgSubmenu.visible = false
            console.log("########## edit");
            Controller.fillStorage(frmSplash.selectedId);
            frmSplash.visible = false
            if (ldlInput.progress == 0.0) {
                ldlInput.source = "InputNocam.qml"
                ldlInput.data = MainStorage
            } else {
                ldlInput.item.visible = true
                ldlInput.setter()
            }

            frmSplash.editing = true
        }

        onDeleteOption: {
            wdgSubmenu.visible = false
            console.log("########## delete");
            Controller.deleteWine(frmSplash.selectedId);
            txtCounter.updateText()
        }
    }

    Button {
        id: btnOk
        imgHeight: 58; imgWidth: 280
        labelText: qsTr("add new wine")
        txtColor: "#FFFFFF"
        txtSize: 30
        current: "imgs/button_bkg.png"
        background: "imgs/button_bkg.png"
        pressed: "imgs/button_bkg.png"
        focused: "imgs/button_bkg.png"
        anchors.bottom: lowerBar.bottom
        anchors.bottomMargin: -8
        anchors.horizontalCenter: lowerBar.horizontalCenter
        onButtonClicked: {
            frmSplash.visible = false
            if (ldlInput.progress == 0.0) {
                ldlInput.source = "InputNocam.qml"
                ldlInput.data = MainStorage
            } else {
                ldlInput.item.visible = true
                ldlInput.setter()
            }
        }

    }

    Text {
        id: txtCounter
        text: updateText()
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 20; }
        anchors.horizontalCenter: lowerBar.horizontalCenter
        anchors.bottom: lowerBar.top
        anchors.bottomMargin: 30

        function updateText() {
            var result;
            var counter = Controller.wineCount()
            if (counter == 0) {
                result = qsTr("Holly Grapes! You haven't tasted a") + "\n" +
                qsTr("single wine, let's fix it!")
            } else if (counter == 1) {
                result = qsTr("You have tasted") + " " + counter + " " +
                qsTr("wine")
            } else {
                result = qsTr("You have tasted") + " " + counter + " " +
                qsTr("wines")
            }

            txtCounter.text = result;
        }


    }

    LanguageMenu {
        id: wdgLanguage
        visible: false
        anchors { top: txtTranslate.bottom; left: txtTranslate.left }
        onLanguageSelected: {
            wdgLanguage.visible = false
            frmSplash.languageChange(locale)
        }
    }

    function processInput() {
        console.log("############# Received")
        var object = List.retrieve("inputone")
        var widget = object.mView
        widget.getter(MainStorage)
        widget.cleanup()

        if (frmSplash.editing) {
            frmSplash.editing = false
            Controller.editWine(frmSplash.selectedId)
        } else {
            Controller.createNewWine()
            txtPosition.updateLabel(0)
            txtCounter.updateText()
        }

        widget.visible = false
        frmSplash.visible = true;
        //XXX: symbian slows down scrolling in main view when camera
        //widget was created.
        if (Controller.system() == 1) {
            widget.destroy(1000);
            List.remove("inputone");
        }

    }

    function cancel() {
        var object = List.retrieve("inputone")
        var widget = object.mView
        widget.visible = false
        frmSplash.visible = true;
        widget.cleanup()
        //XXX: symbian slows down scrolling in main view when camera
        //widget was created.
        if (Controller.system() == 1) {
            widget.destroy(1000);
            List.remove("inputone");
        }

    }

}
