import Qt 4.7

Item {
    id: window
    width: 360; height: 100
    property alias title: wdgCombo.title
    property alias itemLabel: wdgCombo.itemLabel
    property alias listWidth: wdgList.width
    property alias listHeight: wdgList.height
    property alias model: wdgList.currentModel
    property alias value: wdgCombo.itemLabel

    InputCombo {
        id: wdgCombo
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        title: "Connect with"
        itemLabel: "3G+WiFi"
        onClick: {
            wdgList.currentCombo = wdgCombo
            wdgList.currentModelIndex = currentComboIndex
            wdgList.visible = true
            wdgList.opacity = .8
        }
    }

    ComboListComp {
        id: wdgList
        width: 150
        height: 300
        visible: false
        onComboBoxItemSelected: {
            console.log("# Selected..." + currentModelIndex)
            console.log(".... " +
            wdgList.currentModel.get(currentModelIndex).name)
        }
    }

}
