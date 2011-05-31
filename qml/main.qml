import Qt 4.7
import "js/viewcreate.js" as Factory

Item {
    id: appWindow
    width: 362; height: 642
    //width: 480; height: 820
    //width: 1024; height: 600
    Splash {
        id: wdgSplash
        onHideDone: Factory.create("View.qml")
    }

    Timer {
        id: tmDelay
        interval: 1000; running: false; repeat: false;
        onTriggered: wdgSplash.hideSplash()
    }

    Component.onCompleted: tmDelay.running = true
}
