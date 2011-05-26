import Qt 4.7

Screen {
    id: frmSplash

    Image {
        id: imgBarmiddle
        width: parent.width
        anchors.bottom: lowerBar.top
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        fillMode: Image.Tile
        source: "imgs/main_middle_bar.png"
    }

    List {
        id: lstWine
        anchors.top: upperBar.bottom
        anchors.left: upperBar.left
        anchors.right: upperBar.right
        anchors.rightMargin: 30
        anchors.leftMargin: 30
    }

}
