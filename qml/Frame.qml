import Qt 4.7

Rectangle {
    id: background
    anchors.fill: parent
    width:362; height: 642

    BorderImage {
        id: toolbar
        width: parent.width; height: parent.height
        anchors.top: background.top
        anchors.left: background.left
        anchors.right: background.right
        border { left: 10; top: 10; right: 10; bottom: 10 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

    }

}
