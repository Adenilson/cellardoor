import Qt 4.7

Frame {
    id: frmSplash
    signal hideDone()

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Effect {
        id: objPlayer
    }

    BorderImage {
        id: imgBar
        width: parent.width; height: 294
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        y: 85
        border { left: 0; top: 0; right: 0; bottom: 0 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_bluebar.png"
        Behavior on y {
            NumberAnimation { duration: 200 }
        }

        states: [

            State {
                name: "hidden"
                PropertyChanges {
                    target: imgBar
                    y: -height
                }

            },

            State {
                name: "show"
                PropertyChanges {
                    target: imgBar
                    y: 85
                }

            }
        ]

    }

    Timer {
        id: tmLabelCellar
        interval: 1000; running: false; repeat: false;
        onTriggered: imgBar.state = "hidden"
    }

    function hideSplash() {
        //TODO: delay 2s
        hideAnimated()
        objPlayer.play()
        tmLabelCellar.running = true
    }

    Text {
        id: txtWelcome
        text: qsTr("Welcome to")
    	color: "#FFFFFF"
	    font { family: vgRounded.name; pixelSize: 21; italic: true }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.top: imgBar.top
        anchors.topMargin: 50
    }

    Text {
        id: txtAppname
        text: "CellaDoor"
    	color: "#FFFFFF"
	    font { family: nsRegular.name; pixelSize: 42; }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.verticalCenter: imgBar.verticalCenter
        anchors.top: txtWelcome.bottom
        anchors.topMargin: 30
    }


    Text {
        id: txtWelcome2
        text: qsTr("your personal wine journal")
    	color: "#FFFFFF"
	    font { family: vgRounded.name; pixelSize: 21; italic: true }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.top: imgBar.bottom
        anchors.topMargin: -100
    }

}
