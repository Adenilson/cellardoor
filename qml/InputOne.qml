import Qt 4.7

Screen {
    id: frmInput1
	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }


    Text {
        id: txtCellar
        text: "CellaDoor"
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.horizontalCenter: upperBar.horizontalCenter
    }

    BorderImage {
        id: bkgItem
        width: 350; height: 420
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.bottom: lowerBar.top
        anchors.left: frmInput1.left
        anchors.right: frmInput1.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5
    }


}
