import Qt 4.7
import "js/list.js" as List

Screen {
    id: frmInput1
    //width: 360; height: 640
	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }
    signal finish();
    signal cancel();

    lowerBar.height: 90

    function cleanup() {
        wdgFirst.cleanup()
        //TODO: add calls to the other widgets
    }

    function setter(storage) {
        wdgFirst.setter(storage)
        //TODO: add calls to the other widgets
    }

    function getter(storage) {
        wdgFirst.getter(storage)
        //TODO: add calls to the other widgets
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
            }
        }

    }

    Text {
        id: txtAdding
        text: qsTr("Adding a new wine to your Cellar")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 18; italic: true }
        anchors.top: upperBar.top
        anchors.topMargin: 80
        anchors.horizontalCenter: upperBar.horizontalCenter
    }

    Image {
        id: imgLine
        anchors.top: txtAdding.bottom
        anchors.topMargin: 17
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
        imgLine.height + txtSteps.height) * 1.10
        visible: true
    }

    CameraWidget {
        id: wdgThird
        upperBorder: (lowerBar.height + txtAdding.height +
        imgLine.height + txtSteps.height) * 1.10
        onSnaped: console.log("#### I got an image!")
        visible: false
    }

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
            //TODO: this will be done in the last form
            //frmInput1.finish()
            wdgFirst.visible = false
            wdgThird.visible = true
        }

    }

}
