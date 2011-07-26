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
                    wdgCalendar.height = 0
                    wdgCalendar.opacity = 0.0
                } else {
                    wdgCalendar.opacity = 0.8
                    wdgCalendar.height = 360
                }
            }
        }
    }

    Calendar {
        id: wdgCalendar
        anchors.bottom: imgBackground.bottom
        anchors.left: imgBackground.left
        anchors.leftMargin: -5
        height: 0
        opacity: 0.0
        onClicked: {
            txtDescription.text = wdgCalendar.clickedDate
            wdgCalendar.opacity = 0.0
            wdgCalendar.height = 0
        }

        Behavior on opacity {
            NumberAnimation { duration: 500 }
        }

        Behavior on height {
            NumberAnimation { duration: 300 }
        }
    }
}
