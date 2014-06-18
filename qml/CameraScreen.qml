/*  Copyright (C) 2011  Adenilson Cavalcanti <cavalcantii@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; by version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

/* TODO: test this with linux and port to Qt5. */
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
