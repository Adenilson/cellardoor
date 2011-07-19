import Qt 4.7

Rectangle {
    id: wdgParent
    width: 150
    height: 100
    color: "red"

    signal enabled();
    signal disabled();

    MouseArea {
        anchors.fill: parent
        onPressed: {
            if (wdgParent.state == "disabled") {
                wdgParent.state = "enabled";
                wdgParent.enabled();
            } else {
                wdgParent.state = "disabled";
                wdgParent.disabled();
            }
        }
    }

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

    state: "enabled"
    states: [
        State {
            name: "enabled"
            PropertyChanges {
                target: imgCheck
                visible: true
            }

        },

        State {
            name: "disabled"
            PropertyChanges {
                target: imgCheck
                visible: false
            }
        }
    ]

    //TODO: label
}

