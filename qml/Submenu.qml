import Qt 4.7

BorderImage {
    id: wdgSubmenu
    width: 100; height: 100
    border { left: 10; top: 0; right: 10; bottom: 0 }
    horizontalTileMode: BorderImage.Stretch
    verticalTileMode: BorderImage.Stretch
    source: "imgs/list_bg.png"

    signal editOption();
    signal deleteOption();

    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    TextButton {
        id: edit
        width: parent.width
        height: parent.height / 2
        text: qsTr("Edit")
        textColor: "#5a4f3d"
        font { family: nsRegular.name; pixelSize: 20 }
        anchors.top: parent.top
        anchors.left: parent.left
        onClicked: wdgSubmenu.editOption()
    }

    TextButton {
        id: deleteElemt
        width: parent.width
        height: parent.height / 2
        text: qsTr("Delete")
        textColor: "#5a4f3d"
        font { family: nsRegular.name; pixelSize: 20 }
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        onClicked: wdgSubmenu.deleteOption()
    }
}
