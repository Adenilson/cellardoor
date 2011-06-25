import Qt 4.7

Item {
    id: wdgCamera
    //height: 400; width: 300
    width: parent.width; height: parent.height * 0.6
    property int upperBorder: 50
    property int margin: 5
    property bool working: camera.working
    property string picture
    signal snaped()

    function stop() {
        camera.stop()
    }

    function start() {
        camera.start()
    }

    BorderImage {
        id: bkgItem
        width: 350; height: 375
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.top: parent.top
        anchors.topMargin: wdgCamera.upperBorder
        anchors.left: wdgCamera.left
        anchors.right: wdgCamera.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

    }

    CameraScreen {
        id: camera
        anchors.top: bkgItem.top
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
        anchors.bottom: bkgItem.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        Component.onCompleted: snaped.connect(wdgCamera.snaped)
        onSnaped: wdgPicture.source = camera.picture
    }

    /* The button will not be correctly positioned in portrait mode
    Button {
        id: btnSnap
        labelText: ""
        current: "imgs/snap_photo.png"
        background: "imgs/snap_photo.png"
        pressed: "imgs/snap_photo.png"
        focused: "imgs/snap_photo.png"
        anchors.horizontalCenter: wdgCamera.horizontalCenter
        anchors.top: bkgItem.bottom
        onButtonClicked: {
            camera.snap()
        }
    }
    */

    Image {
        id: wdgPicture
        height: 59
        width: 83
        anchors.left: bkgItem.left
        anchors.bottom: bkgItem.top
        anchors.leftMargin: 6
        anchors.bottomMargin: -62
    }

}
