import Qt 4.7

Item {
    width: 339; height: 40
    id: monthHandler
    property string calendarString: ""
    signal previousClicked()
    signal nextClicked()

    //TODO: must be Nokia Sans Semibold
    FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    ImageButton {
        id: prevBtn
        current: "imgs/btn_prev.png"
        background: "imgs/btn_prev.png"
        pressed: "imgs/btn_prev_pressed.png"
        focused: "imgs/btn_prev.png"
        onButtonClicked: monthHandler.previousClicked()
    }

    Image {
        id: calendarStringImg
        source: "imgs/calendar_string_bg.png"
        anchors.left: prevBtn.right
    }

    Text {
        text: calendarString
        font { family: nsRegular.name; pixelSize: 24 }
        color: "#FFFFFF"
        anchors.verticalCenter: calendarStringImg.verticalCenter
        anchors.horizontalCenter: calendarStringImg.horizontalCenter

    }

    ImageButton {
        id: nextBtn
        current: "imgs/btn_next.png"
        background: "imgs/btn_next.png"
        pressed: "imgs/btn_next_pressed.png"
        focused: "imgs/btn_next.png"
        anchors.left: calendarStringImg.right
        onButtonClicked: monthHandler.nextClicked()
    }

}
