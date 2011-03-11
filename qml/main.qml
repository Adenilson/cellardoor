import Qt 4.7

Frame {
    id: frmSplash

    BorderImage {
        id: toolbar
        width: parent.width; height: 294
        anchors.top: frmSplash.top
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        anchors.topMargin: 85
        border { left: 10; top: 10; right: 10; bottom: 10 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_bluebar.png"

    }

}
