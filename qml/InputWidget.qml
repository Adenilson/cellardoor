import Qt 4.7

Item {
    id: wdgInput
    property string title: txtTitle.text
    property string text: txtDescription.text
    width: 400; height: 90

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }


    Text {
        id: txtTitle
        text: "Name"
        color: "#CA893B"
        font { family: nsRegular.name; pixelSize: 16; italic: true }
        anchors.left: wdgInput.left
        anchors.top: wdgInput.top
    }


    Text {
        id: txtDescription
        text: "Description"
        color: "#385661"
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.top: txtTitle.bottom
        anchors.topMargin: 10
        anchors.left: txtTitle.left
    }


}