import Qt 4.7

ListView {
    signal listClicked(int index)
    id: lstOss

    //clip: true
    width: parent.width

    orientation: ListView.Horizontal

    model: Model { id: myModel }
    delegate: Delegate {
        id: myDelegate
        onClicked: lstOss.listClicked(index)
    }

    anchors.bottom: parent.bottom
    spacing: 30
}
