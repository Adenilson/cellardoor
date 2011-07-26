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
                if (wdgCalendar.opacity == 0.8) {
                    wdgCalendar.y = imgBackground.y
                    wdgCalendar.opacity = 0.0
                } else {
                    wdgCalendar.opacity = 0.8
                    wdgCalendar.y = imgBackground.y - wdgCalendar.height + 50
                }
            }
        }
    }

    Calendar {
        id: wdgCalendar
        x: imgBackground.x - 5
        y: imgBackground.y
        visible: true
        opacity: 0.0
        onClicked: {
            txtDescription.text = wdgCalendar.clickedDate
            wdgCalendar.y = imgBackground.y
            wdgCalendar.opacity = 0.0
        }

        Behavior on opacity {
            NumberAnimation { duration: 900 }
        }

        Behavior on y {
            NumberAnimation { duration: 600 }
        }


    }
}
