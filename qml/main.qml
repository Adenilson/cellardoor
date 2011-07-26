import Qt 4.7
import "js/viewcreate.js" as Factory

Item {
    id: appWindow
    width: 362; height: 642
    //width: 480; height: 800
    //width: 1024; height: 600
    //width: 1280; height: 600
    //width: 1280; height: 720
    //width: 540; height: 960
    //width: 480; height: 854

    Splash {
        id: wdgSplash
        onHideDone: {
            var mainview = new Factory.WidgetLoader()
            mainview.create("View.qml")
        }
    }

    Timer {
        id: tmDelay
        interval: 1000; running: false; repeat: false;
        onTriggered: wdgSplash.hideSplash()
    }

    Component.onCompleted: tmDelay.running = true
}
