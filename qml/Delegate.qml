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

    function selectType(type) {

        //TODO: use a map for this
        var result;
        if (type == "Cabernet Sauvignon") {
            result = "imgs/cabernet_sauvignon.png"
        } else if (type == "Merlot") {
            result = "imgs/merlot.png"
        } else if (type == "Pinot Noir") {
            result = "imgs/pinot_noir.png"
        }

        return result;
    }

    Text {
        id: txtName
        text: name
        color: "#3E7E93"
        font { family: nsRegular.name; pixelSize: 22; }
        anchors.top: bkgItem.top
        anchors.topMargin: 7
        anchors.horizontalCenter: bkgItem.horizontalCenter
    }

    Image {
        id: imgBar
        source: "imgs/bar.png"
        anchors.top: txtName.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: txtName.horizontalCenter
    }

    Image {
        id: imgType
        source: selectType(type)
        anchors.top: txtName.bottom
        anchors.topMargin: 12
        anchors.horizontalCenter: txtName.horizontalCenter
    }


    //TODO: move this 2 to a new widget file LabelType
    Image {
        id: imgBackground
        source: "imgs/label.png"
        anchors.top: imgType.bottom
        anchors.topMargin: 8
        anchors.horizontalCenter: imgType.horizontalCenter
    }

    Text {
        id: txtType
        text: type
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 20; }
        anchors.horizontalCenter: imgBackground.horizontalCenter
        anchors.verticalCenter: imgBackground.verticalCenter
    }

}
