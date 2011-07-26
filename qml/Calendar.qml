import Qt 4.7
import "js/calendar.js" as CalendarFunctions

Item {
    id: calendar
    clip: true
    width: 353; height: 360
    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    signal clicked()

    property variant date: new Date()
    property variant clickedDate: calendar.date
    property int _maximumDaysInCalendar: 42

    function reset() {
        CalendarFunctions.populateModel()
    }

    ListModel {
        id: weekModel
        ListElement { week: "Su"; value: 0}
        ListElement { week: "Mon"; value: 1}
        ListElement { week: "Tue"; value: 2}
        ListElement { week: "We"; value: 3}
        ListElement { week: "Th"; value: 4}
        ListElement { week: "Fr"; value: 5}
        ListElement { week: "Sa"; value: 6}
    }

    ListModel {
        id: monthModel
    }

     MonthButton {
        id: monthButton
        calendarString: CalendarFunctions.getMonth() + " " + date.getFullYear()
        anchors.horizontalCenter: calendar.horizontalCenter
        onPreviousClicked: CalendarFunctions.previousMonth()
        onNextClicked: CalendarFunctions.nextMonth()
    }


    Row {
        id: weekElement
        anchors.top: monthButton.bottom
        anchors.horizontalCenter: calendar.horizontalCenter
        Repeater {
            model: weekModel
            Text {
                width: 50
                font { family: nsRegular.name; pixelSize: 19 }
                color: "#FFFFFF"
                horizontalAlignment: Text.AlignHCenter
                text: week
            }
        }
    }

    GridView {
        id: wdgGrid
        width: 343; height: 350
        model: monthModel
        property int previousClicked: -1
        cellWidth: 49; cellHeight: 50
        anchors.top: weekElement.bottom
        anchors.horizontalCenter: calendar.horizontalCenter
        delegate: CalendarDay {
            id: dayDelegate
            day: model.day
            currentMonth: model.currentMonth
            currentDay: model.currentDay
            onButtonClicked: {
                console.log("button says: " + index)
                //First time, just save the index
                if (wdgGrid.previousClicked == -1) {
                    wdgGrid.previousClicked = index
                } else {
                    wdgGrid.currentIndex = wdgGrid.previousClicked
                    var obj = wdgGrid.currentItem
                    obj.reset()
                    wdgGrid.previousClicked = index
                    wdgGrid.currentIndex = wdgGrid.previousClicked
                }
                var modelObj = monthModel.get(index)
                clickedDate = new Date(modelObj.year, modelObj.month, modelObj.day,
                                       clickedDate.getHours(),
        clickedDate.getMinutes())
                calendar.clicked()
            }
         }
    }

    Component.onCompleted: { CalendarFunctions.populateModel() }
}
