import Qt 4.7
import "js/viewcreate.js" as Factory

Item {
    id: appWindow
    width: 362; height: 642
    SplashNoSound {
        id: wdgSplash
    }

    Timer {
        id: tmSplash
        interval: 1100; running: false; repeat: false;
        onTriggered: {
            wdgSplash.hideSplash()
        }
    }

    Timer {
        id: tmView
        interval: 2000; running: false; repeat: false;
        onTriggered: Factory.create()
    }


    Component.onCompleted: {
        tmSplash.running = true
        tmView.running = true
    }
}
