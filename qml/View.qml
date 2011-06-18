import Qt 4.7
import "js/viewcreate.js" as Factory
import "js/list.js" as List

Screen {
    id: frmSplash
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    lowerBar.height: 75
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
                input.create("InputOne.qml")
                input.mView.finish.connect(frmSplash.processInput)
                List.append("inputone", input)
            } else {
                var widget = object.mView
                console.log("### Found: " + widget.height)
                //This will be used for edit operation
                //widget.setter(MainStorage)
                widget.visible = true
            }
        }

    }

    function processInput() {
        frmSplash.visible = true;
        console.log("############# Received")
        var object = List.retrieve("inputone")
        var widget = object.mView
        widget.getter(MainStorage)
        widget.cleanup()
        Controller.createNewWine()
    }


}
