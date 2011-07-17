import Qt 4.7

Rectangle {
    id: background
    //This will block any x/y animation
    //anchors.fill: parent
    width: parent.width; height: parent.height
    signal animationCompleted


    BorderImage {
        id: toolbar1
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: 0
        border { left: 0; top: 0; right: 0; bottom: 0 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

    }

    BorderImage {
        id: toolbar2
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: parent.width / 2
        border { left: 0; top: 0; right: 0; bottom: 0 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

    }

    ParallelAnimation {
        id: animSlide
        NumberAnimation { target: toolbar1; property: "x";
                          to: -toolbar1.width; duration: 700 }
        NumberAnimation { target: toolbar2; property: "x";
                          to: toolbar2.x + toolbar2.width; duration: 700 }

        onRunningChanged: if (!running) background.animationCompleted()

    }

    function hideAnimated() {
        animSlide.running = true
    }

}
