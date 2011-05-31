import Qt 4.7

Screen {
    id: frmInput1
	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    lowerBar.height: 90

    Text {
        id: txtCellar
        text: "CellaDoor"
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.verticalCenter: upperBar.verticalCenter
        anchors.horizontalCenter: upperBar.horizontalCenter
    }


    Text {
        id: txtAdding
        text: qsTr("Adding a new wine to your Cellar")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 18; italic: true }
        anchors.top: upperBar.top
        anchors.topMargin: 80
        anchors.horizontalCenter: upperBar.horizontalCenter
    }

    Image {
        id: imgLine
        anchors.top: txtAdding.bottom
        anchors.topMargin: 17
        anchors.horizontalCenter: upperBar.horizontalCenter
        source: "imgs/line_break.png"
    }

    Text {
        id: txtSteps
        text: qsTr("Step 1")
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 28; }
        anchors.top: imgLine.bottom
        anchors.horizontalCenter: imgLine.horizontalCenter
    }


    BorderImage {
        id: bkgItem
        width: 350; height: 375
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.bottom: lowerBar.top
        anchors.left: frmInput1.left
        anchors.right: frmInput1.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

    }

    InputWidget {
        id: wdgName
        title: qsTr("Name")
        text: "Casillero Del Diablo"
        anchors.top: bkgItem.top
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgType
        title: qsTr("Kind of Wine")
        text: "Merlot"
        anchors.top: wdgName.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgProducer
        title: qsTr("Producer")
        text: "Vinos Del Castilho"
        anchors.top: wdgType.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgYear
        title: qsTr("Vintage Year")
        text: "17/02/2011"
        height: 50; width: 150
        anchors.top: wdgProducer.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

    InputWidget {
        id: wdgPrice
        title: qsTr("Price")
        text: "$30.00"
        height: 50; width: 150
        anchors.top: wdgProducer.bottom
        anchors.topMargin: 5
        anchors.right: bkgItem.right
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

}
