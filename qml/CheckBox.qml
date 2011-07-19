import Qt 4.7

Rectangle {
    width: 150
    height: 100
    color: "red"

    Rectangle {
        id: wdgRect
        width: 35
        height: 35
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 5
        smooth: true
    }

    Image {
        id: imgCheck
        source: "imgs/check_mark.png"
        anchors.left: wdgRect.left
        anchors.top: wdgRect.top
        anchors.bottom: wdgRect.bottom
    }

    //TODO: add mouse events, 2 states, label
}

