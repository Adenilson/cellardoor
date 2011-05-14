import Qt 4.7

ListView {
    signal listClicked(int index)
    id: lstOss

    clip: true
    width: parent.width
    //width: 306; height: 297

    orientation: ListView.Horizontal

    model: Model { id: myModel }
    delegate: Delegate {
        id: myDelegate
        onClicked: lstOss.listClicked(index)
    }

    anchors.bottom: parent.bottom
    spacing: 30
}
