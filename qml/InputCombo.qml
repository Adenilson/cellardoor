import Qt 4.7

InputBase {
    id: wdgCombo

    title: "Combo"
    property string itemLabel: "Title"
    property int currentComboIndex: 0

    signal click()

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Text {
        id: txtDescription
        text: wdgCombo.itemLabel
        color: "#385661"
        elide: Text.ElideRight
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.left: txtTitle.left
        anchors.right: imgBackground.right
        anchors.verticalCenter: imgBackground.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: click()

            onPressed: {
                wdgCombo.opacity = 0.70
            }
            onReleased: {
                wdgCombo.opacity = 1.0
            }

        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: click()

        onPressed: {
            wdgCombo.opacity = 0.70
        }
        onReleased: {
            wdgCombo.opacity = 1.0
        }
    }


}
