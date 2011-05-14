import Qt 4.7

Frame {
    id: frmSplash

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Image {
        id: imgBarup
        width: parent.width; height: 62
        anchors.top: frmSplash.top
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.Tile
        source: "imgs/main_top_bar.png"
    }

    Image {
        id: imgBarmiddle
        width: parent.width; height: 245
        anchors.bottom: imgBarlower.bottom
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.Tile
        source: "imgs/main_middle_bar.png"
    }

    Image {
        id: imgBarlower
        width: parent.width; height: 60
        anchors.bottom: frmSplash.bottom
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.Tile
        source: "imgs/main_low_bar.png"
    }

    List {
        id: lstWine
        anchors.top: imgBarup.bottom
        anchors.topMargin: 30
        anchors.left: imgBarup.left
        anchors.right: imgBarup.right
    }

}
