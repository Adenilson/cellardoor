import Qt 4.7

Item {

    width: 362; height: 642
    Splash {
        id: wdgSplash
    }

    Timer {
        id: tmSplash
        interval: 1100; running: false; repeat: false;
        onTriggered: wdgSplash.hideSplash()
    }

    Component.onCompleted: tmSplash.running = true
}
