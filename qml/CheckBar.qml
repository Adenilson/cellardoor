import Qt 4.7

Item {

    id: frmParent
    width: 360; height: 200
    property int currentState: 0
    signal filter(int state)

    CheckBox {
        id: chkRed
        anchors.top: frmParent.top
        anchors.topMargin: 15
        anchors.left: frmParent.left
        onDisabled: frmParent.disable("red", chkRed)
        onEnabled: frmParent.enable("red", chkRed)
    }

    CheckBox {
        id: chkWhite
        label: qsTr("White")
        anchors.top: frmParent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: frmParent.horizontalCenter
        onDisabled: frmParent.disable("white", chkWhite);
        onEnabled: frmParent.enable("white", chkWhite);

    }

    CheckBox {
        id: chkOther
        label: qsTr("Other")
        anchors.top: frmParent.top
        anchors.topMargin: 15
        anchors.right: frmParent.right
        onDisabled: frmParent.disable("other", chkOther)
        onEnabled: frmParent.enable("other", chkOther)

    }

    function disable(name, widget)
    {
        console.log("########## disable: " + name + " state: " + widget.state);
        if (name == "red" && frmParent.currentState == 0) {
            frmParent.currentState = 3
        } else if (name == "white" && frmParent.currentState == 0) {
            frmParent.currentState = 6
        } else if (name == "other" && frmParent.currentState == 0) {
            frmParent.currentState = 1
        } else if (name == "white" && frmParent.currentState == 3) {
            frmParent.currentState = 5
        } else if (name == "white" && frmParent.currentState == 1) {
            frmParent.currentState = 2
        } else if (name == "other" && frmParent.currentState == 3) {
            frmParent.currentState = 4
        } else if (name == "other" && frmParent.currentState == 5) {
            frmParent.currentState = 7
        } else if (name == "other" && frmParent.currentState == 6) {
            frmParent.currentState = 2
        } else if (name == "red" && frmParent.currentState == 6) {
            frmParent.currentState = 5
        } else if (name == "white" && frmParent.currentState == 3) {
            frmParent.currentState = 5
        } else if (name == "red" && frmParent.currentState == 2) {
            frmParent.currentState = 7
        } else if (name == "white" && frmParent.currentState == 4) {
            frmParent.currentState = 7
        } else if (name == "white" && frmParent.currentState == 1) {
            frmParent.currentState = 2
        } else if (name == "red" && frmParent.currentState == 1) {
            frmParent.currentState = 4
        }

        frmParent.filter(frmParent.currentState)
    }

    function enable(name, widget)
    {
        console.log("########## disable: " + name + " state: " + widget.state);
        if (name == "red" && frmParent.currentState == 3) {
            frmParent.currentState = 0

        } else if (name == "white" && frmParent.currentState == 6) {
            frmParent.currentState = 0

        } else if (name == "other" && frmParent.currentState == 1) {
            frmParent.currentState = 0
        }

        frmParent.filter(frmParent.currentState)
    }

    function processStates()
    {
        if (frmParent.state == "s0") {
            frmParent.state = "s4";
        } else
            frmParent.state = "s0";

    }

    // state: "s0"
    // states: [
    //     State {
    //         name: "s0"
    //         PropertyChanges {
    //             target: frmParent
    //             currentState: "enabled"
    //         }
    //         PropertyChanges {
    //             target: chkWhite
    //             state: "enabled"
    //         }
    //         PropertyChanges {
    //             target: chkOther
    //             state: "enabled"
    //         }

    //     },
    //     State {
    //         name: "s4"
    //         PropertyChanges {
    //             target: chkRed
    //             state: "enabled"
    //         }
    //         PropertyChanges {
    //             target: chkWhite
    //             state: "enabled"
    //         }
    //         PropertyChanges {
    //             target: chkOther
    //             state: "disabled"
    //         }

    //     }
    // ]

}
