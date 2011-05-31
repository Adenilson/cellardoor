import Qt 4.7
import "js/viewcreate.js" as Factory

Item {
    id: appWindow
    width: 362; height: 642
    SplashNoSound {
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
