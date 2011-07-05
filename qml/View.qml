import Qt 4.7
import "js/viewcreate.js" as Factory
import "js/list.js" as List

Screen {
    id: frmSplash
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    //width: 360; height: 640
    lowerBar.height: 75
    property int selectedId: 0
    property bool editing: false
    Image {
        id: imgBarmiddle
        width: parent.width
        height: 165
        anchors.bottom: lowerBar.top
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.TileHorizontally
        source: "imgs/main_middle_bar.png"
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

    List {
        id: lstWine
        anchors.top: upperBar.bottom
        anchors.left: upperBar.left
        anchors.right: upperBar.right
        anchors.rightMargin: 30
        anchors.leftMargin: 30
        anchors.bottom: lowerBar.top
        anchors.bottomMargin: 200

        onListClicked: {
            if (wdgSubmenu.visible) {
                wdgSubmenu.visible = false
            }
            console.log("###### clicked: " + index)
            //TODO: show detailed view
        }

        onListPressAndHold: {
            console.log("########x: " + x + "\ty: " + y + "\tid: " + id)
            var delta = 30
            frmSplash.selectedId = id
            wdgSubmenu.x = x - delta; wdgSubmenu.y = y - delta;
            wdgSubmenu.visible = true
        }
    }

    Submenu {
        id: wdgSubmenu
        visible: false
        onEditOption: {
            wdgSubmenu.visible = false
            console.log("########## edit");
            Controller.fillStorage(frmSplash.selectedId);

            //TODO: this code must be moved to a common function
            var object = List.retrieve("inputone")
            var widget = null
            if (object == null) {
                console.log("##### Not found, creating the input now!")
                var input = new Factory.WidgetLoader()
                frmSplash.visible = false;
                //XXX: If the environment lacks Camera, go with no cam form
                if (Controller.system() == 2) {
                    input.create("InputNocam.qml")
                    console.log("######## Nocam WIN")
                } else if (Controller.system() == 1) {
                    input.create("InputNocam.qml")
                    console.log("######## Nocam SYMBIAN")
                } else if (Controller.system() == 0) {
                    input.create("Input.qml")
                    console.log("######## Camera Linux")
                }


                input.mView.finish.connect(frmSplash.processInput)
                input.mView.cancel.connect(frmSplash.cancel)
                List.append("inputone", input)
                widget = input.mView

            } else {
                widget = object.mView
                console.log("### Found: " + widget.height)
                frmSplash.visible = false;
                //TODO: show with style
                widget.visible = true
            }

            widget.setter(MainStorage)
            frmSplash.editing = true
        }

        onDeleteOption: {
            wdgSubmenu.visible = false
            console.log("########## delete");
            Controller.deleteWine(frmSplash.selectedId);
            txtCounter.counter = Controller.wineCount()
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
        anchors.horizontalCenter: lowerBar.horizontalCenter
        onButtonClicked: {
            var object = List.retrieve("inputone")
            if (object == null) {
                console.log("##### Not found, creating the input now!")
                var input = new Factory.WidgetLoader()
                frmSplash.visible = false;
                //XXX: If the environment lacks Camera, go with no cam form
                if (Controller.system() == 2) {
                    input.create("InputNocam.qml")
                    console.log("######## Nocam WIN")
                } else if (Controller.system() == 1) {
                    input.create("InputNocam.qml")
                    console.log("######## Nocam SYMBIAN")
                } else if (Controller.system() == 0) {
                    input.create("Input.qml")
                    console.log("######## Camera Linux")
                }

                input.mView.finish.connect(frmSplash.processInput)
                input.mView.cancel.connect(frmSplash.cancel)
                List.append("inputone", input)
            } else {
                var widget = object.mView
                console.log("### Found: " + widget.height)
                frmSplash.visible = false;
                //TODO: show with style
                widget.visible = true
            }
        }

    }

    Text {
        id: txtCounter
        property string counter: Controller.wineCount()
        text: qsTr("You have tasted") + " " + counter + " " + qsTr("wines")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 20; }
        anchors.horizontalCenter: lowerBar.horizontalCenter
        anchors.bottom: lowerBar.top
        anchors.bottomMargin: 30

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
            txtCounter.counter = Controller.wineCount()
        }

        widget.visible = false
        frmSplash.visible = true;
    }

    function cancel() {
        var object = List.retrieve("inputone")
        var widget = object.mView
        widget.visible = false
        frmSplash.visible = true;
        widget.cleanup()
    }

}
