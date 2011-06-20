import Qt 4.7

Item {
    width: parent.width; height: parent.height
    property string text: ""
    property alias textColor: txtOption.color
    property alias font: txtOption.font
    signal clicked()

    Text {
        id: txtOption
    	text: parent.text
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
