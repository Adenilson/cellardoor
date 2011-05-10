import Qt 4.7

Rectangle {
    id: background
    anchors.fill: parent
    width: 362; height: 642

    BorderImage {
        id: toolbar1
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: 0
        border { left: 10; top: 10; right: 10; bottom: 10 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

        Behavior on x {
            NumberAnimation { duration: 700 }
        }

        states: [

            State {
                name: "hidden"
                PropertyChanges {
                    target: toolbar1
                    x: -toolbar1.width
                }

            },

            State {
                name: "show"
                PropertyChanges {
                    target: toolbar1
                    x: 0
                }

            }
        ]

        MouseArea {
            anchors.fill: parent
            onClicked: {
                    console.log("clicked!")
                    toolbar1.state = "hidden"
            }
        }

    }

    BorderImage {
        id: toolbar2
        width: parent.width/2; height: parent.height
        anchors.top: background.top
        anchors.bottom: background.bottom
        x: parent.width / 2
        border { left: 10; top: 10; right: 10; bottom: 10 }
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Stretch
        source: "imgs/splash_WOOD.png"

        Behavior on x {
            NumberAnimation { duration: 800 }
        }

        states: [

            State {
                name: "hidden"
                PropertyChanges {
                    target: toolbar2
                    x: toolbar2.x + toolbar2.width
                }

            },

            State {
                name: "show"
                PropertyChanges {
                    target: toolbar1
                    x: parent.width/2
                }

            }
        ]

        MouseArea {
            anchors.fill: parent
            onClicked: {
                    console.log("clicked!")
                    toolbar2.state = "hidden"
            }
        }

    }


}
