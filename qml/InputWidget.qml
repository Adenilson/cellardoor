import Qt 4.7

InputBase {
    id: wdgInput

    property alias text: txtDescription.text
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    TextEdit {
        id: txtDescription
        text: "Description"
        color: "#385661"
        //FIXME: elide the text
        //elide: Text.ElideRight
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.left: txtTitle.left
        anchors.right: imgBackground.right
        anchors.verticalCenter: imgBackground.verticalCenter
    }


}
