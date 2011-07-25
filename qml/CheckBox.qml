import Qt 4.7

Item {
    id: wdgParent
    width: 100
    height: 40

    property string label: qsTr("Red")
    signal enabled();
    signal disabled();

	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

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
        smooth: true
        width: 39; height: 39
        anchors.left: wdgRect.left
        anchors.top: wdgRect.top
        anchors.bottom: wdgRect.bottom
    }

    Text {
        id: txtCheck
        text: wdgParent.label
        color: "#FFFFFF"
        font { family: nsRegular.name; pixelSize: 22 }
        anchors.left: wdgRect.right
        anchors.leftMargin: 10
        anchors.top: wdgRect.top
        anchors.topMargin: 5

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

    //TODO: fade transition on check state change

}

