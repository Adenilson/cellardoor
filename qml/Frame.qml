import Qt 4.7

Rectangle {
    id: background
    anchors.fill: parent
    width: 362; height: 642
    signal animationCompleted


    BorderImage {
        id: toolbar1
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: 0
        border { left: 10; top: 10; right: 10; bottom: 10 }
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
        border { left: 10; top: 10; right: 10; bottom: 10 }
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
