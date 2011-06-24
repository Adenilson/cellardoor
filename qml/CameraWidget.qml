import Qt 4.7
import QtMultimediaKit 1.1

Item {
    id: wdgCamera
    height: 400; width: 300
    property int margin: 5
    property bool working: true
    property string picture

    CameraScreen {
        id: camera
        anchors.topMargin: 10
    }

    Button {
        id: btnSnap
        labelText: qsTr("Snap!")
        anchors.horizontalCenter: wdgCamera.horizontalCenter
        anchors.bottom: wdgCamera.bottom
        anchors.leftMargin: 12
        onButtonClicked: {
            camera.snap()
        }
    }

    Image {
        id: wdgPicture
        height: 72
        width: 100
        anchors.left: parent.left
        anchors.bottom: btnSnap.bottom
        anchors.leftMargin: 10
    }

}
