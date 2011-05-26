import Qt 4.7

Frame {
    id: frmScreen

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    property alias upperBar: imgBarup
    property alias lowerBar: imgBarlower

    Image {
        id: imgBarup
        width: parent.width; height: 62
        anchors.top: frmScreen.top
        anchors.left: frmScreen.left
        anchors.right: frmScreen.right
        fillMode: Image.Tile
        source: "imgs/main_top_bar.png"
    }

    Image {
        id: imgBarlower
        width: parent.width; height: 60
        anchors.bottom: frmScreen.bottom
        anchors.left: frmScreen.left
        anchors.right: frmScreen.right
        fillMode: Image.Tile
        source: "imgs/main_low_bar.png"
    }

}
