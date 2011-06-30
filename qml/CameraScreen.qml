import Qt 4.7
import QtMultimediaKit 1.1

Item {
    id: wdgCamera
    height: parent.height * 0.7; width: parent.width * 0.9
    anchors.right: parent.right
    anchors.left: parent.left
    property int margin: 5
    property bool working: true
    property string picture
    signal snaped()

    function snap() {
        if (wdgCamera.working == false) {
            camera.focus = visible
            camera.start()
        }

        camera.captureImage()
        wdgCamera.working = false
        camera.focus = !visible
        camera.stop()

        wdgCamera.working = true
        camera.focus = visible
        camera.start()
        camera.captureImage()
    }

    function stop() {
        wdgCamera.working = false
        camera.focus = !visible
        camera.stop()
    }

    function start() {
        wdgCamera.working = true
        camera.focus = visible
        camera.start()
    }

    Camera {
        id: camera
        width: parent.width - wdgCamera.margin
        height: parent.height - wdgCamera.margin
        anchors.horizontalCenter: wdgCamera.horizontalCenter
        anchors.top: wdgCamera.top
        focus: visible

        onImageCaptured: {
            wdgPicture.source =  preview + ".jpg"
        }

        onImageSaved: {
            //Works in qmlviewer
            //wdgCamera.picture = path
            if (Controller.system() == 0) {
                wdgCamera.picture = Controller.workingDir() + path
            } else if (Controller.system() == 1) {
                wdgCamera.picture = path
            } else {
                console.log("### Need to test in windows...")
            }

            console.log("Value is: " + Controller.system() + "\tpath:" + path)
            wdgCamera.snaped()
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                snap()
            }
        }

    }

}
