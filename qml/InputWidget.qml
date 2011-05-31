import Qt 4.7

Item {
    id: wdgInput
    property alias title: txtTitle.text
    property alias text: txtDescription.text
    width: 400; height: 90

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }


    Text {
        id: txtTitle
        text: "Name"
        color: "#CA893B"
        font { family: nsRegular.name; pixelSize: 16; italic: true }
        anchors.left: wdgInput.left
        anchors.leftMargin: 20
        anchors.top: wdgInput.top
    }


    BorderImage {
        id: imgBackground
        border { left: 10; top: 10; right: 10; bottom: 10 }
        anchors.top: txtTitle.bottom
        anchors.topMargin: 5
        anchors.left: wdgInput.left
        anchors.leftMargin: 10
        anchors.right: wdgInput.right
        anchors.rightMargin: 10
        source: "imgs/edit_bkg.png"
    }

    TextEdit {
        id: txtDescription
        text: "Description"
        color: "#385661"
        //FIXME: elide the text
        //elide: Text.ElideRight
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.left: txtTitle.left
        anchors.verticalCenter: imgBackground.verticalCenter
    }


}
