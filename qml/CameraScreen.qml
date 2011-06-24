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

    function snap() {
        camera.captureImage()
        wdgCamera.working = false
        camera.focus = !visible
        camera.stop()

        wdgCamera.working = true
        camera.focus = visible
        camera.start()
        camera.captureImage()
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
            //Works in Linux
            wdgCamera.picture = Controller.workingDir() + path
            //Works in Symbian
            //wdgPicture.source = path
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                snap()
            }
        }

    }

}