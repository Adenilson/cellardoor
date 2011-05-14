import Qt 4.7

BorderImage {
    id: bkgItem
    signal clicked(int index)
    width: 306; height: 297
    border { left: 10; top: 10; right: 10; bottom: 10 }
    // anchors.left: parent.left
    // anchors.right: parent.right
    source: "imgs/main_item_bkg.png"

}
