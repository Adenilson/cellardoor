import Qt 4.7

Rectangle {
    id: item

    property string itemText: "Title"
    property string itemLabel: "1"
    property double itemWidth: 480
    property bool clicked: false
    property int currentComboIndex: 0

    signal click()

    width: itemWidth
    height: label.paintedHeight + 38
    color: "#FFF"

    Behavior on color {
        ColorAnimation { duration: 100 }
    }

    Text {
        id: label
        width: itemWidth - 30

        text: itemText
        font.family: "Nokia Standard"
        font.weight: "Bold"
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

    Rectangle {
        color: "#000"
        width: labelText.paintedWidth + 25
        height: labelText.paintedHeight + 15
        radius: 15

        Text {
            id: labelText
            text: itemLabel

            font.family: "Nokia Standard"
            font.weight: "Bold"
            font.capitalization: Font.Capitalize
            font.pixelSize:  16
            anchors.centerIn: parent
            color: "#FFF"
        }
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right; anchors.rightMargin: 10
    }

    MouseArea {
        anchors.fill: parent
        onClicked: click()

        onPressed: {
            item.color = "#CCC"
        }
        onReleased: {
            item.color = "#FFF"
        }
    }
}
