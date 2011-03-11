import Qt 4.7

Frame {
    id: frmSplash

	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    BorderImage {
        id: imgBar
        width: parent.width; height: 294
        anchors.top: frmSplash.top
        anchors.left: frmSplash.left
        anchors.right: frmSplash.right
        anchors.topMargin: 85
        border { left: 10; top: 10; right: 10; bottom: 10 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_bluebar.png"
    }

    Text {
        id: txtWelcome
        text: "Welcome to"
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
        text: "your personal wine journal"
    	color: "#FFFFFF"
	    font { family: vgRounded.name; pixelSize: 21; italic: true }
        anchors.horizontalCenter: imgBar.horizontalCenter
        anchors.top: imgBar.bottom
        anchors.topMargin: -100
    }

}
