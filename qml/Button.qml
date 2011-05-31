import Qt 4.7

Item {
    id: button
    property string labelText: "ouch!"
    property string current: "imgs/textbutton.png"
    property string background: "imgs/textbutton.png"
    property string pressed: "imgs/textbutton_pressed.png"
    property string focused: "imgs/textbutton_focused.png"
    signal buttonClicked
    width: 82
    height: 78
    property alias imgWidth: background.width
    property alias imgHeight: background.height
    property alias txtColor: label.color
    property int txtSize: 16

    Image {
        id: background
        source: button.current
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        signal buttonClicked

        MouseArea {
		  anchors.fill: parent
		  hoverEnabled: true
		  onPressed: button.current = button.pressed
		  onClicked: {
		  			button.current = button.background
					button.buttonClicked()
                             }
		  onEntered: button.current = button.focused
		  onExited: button.current = button.background
        }

    }

    Text {
        id: label
        text: button.labelText
        color: "#352d2a"
        font { pixelSize: button.txtSize }
        anchors.horizontalCenter: background.horizontalCenter
        anchors.verticalCenter: background.verticalCenter
        //anchors.topMargin: 2
    }
}
