import Qt 4.7

Rectangle {
    id: comboListItem
    property string itemText: "Label"

    signal selected()

    width: parent.width
    color: "transparent"
    height: label.paintedHeight + 38

    Text {
        id: label
        width: parent.width - 30

        text: itemText
        font.family: "Nokia Standard"
        font.weight: "Bold"
        color: "#FFF"
        font.capitalization: Font.Capitalize
        font.pixelSize:  24
        wrapMode:  Text.WordWrap

        clip: true

        anchors.verticalCenter: parent.verticalCenter
        anchors.topMargin: 8;
        anchors.bottomMargin: 10
        anchors.right: parent.right; anchors.rightMargin: 65
        anchors.left: parent.left; anchors.leftMargin: 15
    }
    MouseArea {
        anchors.fill: parent
        onClicked:  {
            optionList.currentIndex = index
            selected()
        }
        onPressed: {
            comboListItem.color = "#F0BEBEBE"
        }

        onReleased: {
            comboListItem.color = "transparent"
        }
    }
    Behavior on color {
        ColorAnimation {
            duration: 50;
        }
    }
}
