import Qt 4.7
import QtMultimediaKit 1.1

Item {
    id: wdgCamera
    height: 360; width: 640
    property int margin: 50
    property bool working: true

    Camera {
        id: camera
        x: 50; y: 10
        width: parent.width - wdgCamera.margin
        height: parent.height - wdgCamera.margin
        focus: visible

        onImageCaptured: {
            wdgPicture.source = preview + ".jpg"
            console.log("#### image captured...")
        }

        onImageSaved: {
            wdgPicture.source = path
            console.log("#### saved!:" + path)
        }

    }

    Button {
        id: btnSnap
        labelText: qsTr("Snap!")
        anchors.left: wdgCamera.left
        anchors.top: wdgCamera.top
        anchors.leftMargin: 12
        onButtonClicked: {
            //XXX: should work, but...
            //if (wdgCamera.working) {
                camera.captureImage()
                wdgCamera.working = false
                camera.focus = !visible
                camera.stop()
            //} else {
                wdgCamera.working = true
                camera.focus = visible
                camera.start()
                camera.captureImage()
            //}
        }
    }

    Image {
        id: wdgPicture
        height: 72
        width: 100
        anchors.left: parent.left
        anchors.top: btnSnap.bottom
        anchors.leftMargin: 10
    }

}
