import Qt 4.7

Screen {
    id: frmSplash

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }


    Image {
        id: imgBarmiddle
        width: parent.width; height: 245
        anchors.bottom: lowerBar.bottom
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.Tile
        source: "imgs/main_middle_bar.png"
    }

    List {
        id: lstWine
        anchors.top: upperBar.bottom
        //anchors.topMargin: 30
        anchors.left: upperBar.left
        anchors.right: upperBar.right
        anchors.rightMargin: 30
        anchors.leftMargin: 30
    }

}
