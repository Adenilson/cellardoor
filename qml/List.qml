import Qt 4.7

ListView {
    id: lstOss
    width: parent.width
    signal listClicked(int index)
    signal listPressAndHold(int index, int x, int y)

    orientation: ListView.Horizontal

    //model: Model { id: myModel }
    model: WineModel
    delegate: Delegate {
        id: myDelegate
        onClicked: lstOss.listClicked(index)
        onPressAndHold:  {
            var obj = myDelegate.mapToItem(lstOss, x, y)
            lstOss.listPressAndHold(index, obj.x, obj.y)
        }

    }

    anchors.bottom: parent.bottom
    spacing: 30
}
