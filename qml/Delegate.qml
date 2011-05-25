import Qt 4.7

BorderImage {
    id: bkgItem
    signal clicked(int index)
    width: 306; height: 297
    border { left: 10; top: 10; right: 10; bottom: 10 }
    source: "imgs/main_item_bkg.png"

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    function upperCase(text) {
        return text.toUpperCase(text)
    }

    Text {
        id: txtName
        text: name
        color: "#3E7E93"
        font { family: nsRegular; pixelSize: 22; }
        anchors.top: bkgItem.top
        anchors.topMargin: 7
        anchors.horizontalCenter: bkgItem.horizontalCenter
    }

}
