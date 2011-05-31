import Qt 4.7
import "js/viewcreate.js" as Factory
import "js/list.js" as List
Item {
    id: appWindow
    width: 362; height: 642
    //width: 480; height: 820
    //width: 1024; height: 600

    Splash {
        id: wdgSplash
        onHideDone: {
            var mainview = new Factory.WidgetLoader()
            mainview.create("View.qml")
            List.append("winelist", mainview)
        }
    }

    Timer {
        id: tmDelay
        interval: 1000; running: false; repeat: false;
        onTriggered: wdgSplash.hideSplash()
    }

    Component.onCompleted: tmDelay.running = true
}
