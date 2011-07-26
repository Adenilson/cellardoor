import Qt 4.7

InputBase {
    id: wdgCalendarInput

    property alias date: txtDescription.text
    title: "Date"

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    Text {
        id: txtDescription
        text: "Description"
        color: "#385661"
        elide: Text.ElideRight
        font { family: nsRegular.name; pixelSize: 18 }
        anchors.left: txtTitle.left
        anchors.right: imgBackground.right
        anchors.verticalCenter: imgBackground.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (wdgCalendar.visible == true) {
                    wdgCalendar.y = imgBackground.y + 50
                    wdgCalendar.visible = false
                } else {
                    wdgCalendar.visible = true
                    wdgCalendar.y = imgBackground.y - wdgCalendar.height + 50
                }
            }
        }
    }

    Calendar {
        id: wdgCalendar
        x: imgBackground.x - 5
        y: imgBackground.y + 50
        visible: false
        onClicked: txtDescription.text = wdgCalendar.clickedDate
    }
}
