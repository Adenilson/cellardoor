import Qt 4.7

ListView {
    id: lstOss
    width: parent.width
    signal listClicked(int index, int id)
    signal listPressAndHold(int id, int x, int y)

    orientation: ListView.Horizontal

    //model: Model { id: myModel }
    model: WineModel
    delegate: Delegate {
        id: myDelegate
        onClicked: lstOss.listClicked(index, id)
        onPressAndHold:  {
            var obj = myDelegate.mapToItem(lstOss, x, y)
            lstOss.listPressAndHold(id, obj.x, obj.y)
        }

    }

    anchors.bottom: parent.bottom
    spacing: 30
}
