import Qt 4.7

InputBase {
    id: wdgCalendarInput

    property string text: "1999"
    title: "Date"

    Calendar {
        id: wdgCalendar
        x: imgBackground.x - 5
        y: imgBackground.y + 50
        visible: false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("######### clicked!")
            wdgCalendar.visible = true
            wdgCalendar.y = imgBackground.y - wdgCalendar.height + 50
        }

    }
}
