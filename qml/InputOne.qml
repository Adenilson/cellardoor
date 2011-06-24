import Qt 4.7
import "js/list.js" as List

Item {
    id: frmInput1
    //width: 360; height: 640
    property int upperBorder: 50
    width: parent.width; height: parent.height * 0.6
	FontLoader { id: vgRounded; source: "fonts/VAG_Rounded.ttf" }
	FontLoader { id: nsRegular; source: "fonts/Nokia_Sans_Regular.ttf" }

    BorderImage {
        id: bkgItem
        width: 350; height: 375
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "imgs/main_item_bkg.png"
        anchors.top: parent.top
        anchors.topMargin: frmInput1.upperBorder
        anchors.left: frmInput1.left
        anchors.right: frmInput1.right
        anchors.leftMargin: 5
        anchors.rightMargin: 5

    }

    InputWidget {
        id: wdgName
        title: qsTr("Name")
        text: "Wine name here"
        anchors.top: bkgItem.top
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    function cleanup() {
        wdgName.text = "Wine name here"
        wdgType.text = "Grape type e.g Merlot"
        wdgProducer.text = "Vineyard"
        wdgYear.text = "YYYY"
        wdgPrice.text = "$bucks"
    }

    function setter(storage) {
        wdgName.text = storage.name
        wdgType.text = storage.grape
        wdgProducer.text = storage.producer
        wdgYear.text = storage.year
        wdgPrice.text = "$" + storage.price
    }

    function getter(storage) {
        storage.name = wdgName.text;
        //TODO: this must be a combobox
        //storage.type = wdgType.text;
        storage.grape = wdgType.text;
        storage.producer = wdgProducer.text
        storage.year = wdgYear.text

        var tmp = wdgPrice.text.indexOf("$")
        if (tmp != -1) {
            tmp = wdgPrice.text.substr(tmp + 1, wdgPrice.text.length)
        } else {
            tmp = wdgPrice.text
        }
        storage.price = tmp

        //TODO: region, tasting, etc
    }

    InputWidget {
        id: wdgType
        title: qsTr("Kind of Wine")
        text: "Grape type e.g Merlot"
        anchors.top: wdgName.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgProducer
        title: qsTr("Producer")
        text: "Vineyard"
        anchors.top: wdgType.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.right: bkgItem.right
    }

    InputWidget {
        id: wdgYear
        title: qsTr("Vintage Year")
        text: "YYYY"
        height: 50; width: 150
        anchors.top: wdgProducer.bottom
        anchors.topMargin: 5
        anchors.left: bkgItem.left
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

    InputWidget {
        id: wdgPrice
        title: qsTr("Price")
        text: "$bucks"
        height: 50; width: 150
        anchors.top: wdgProducer.bottom
        anchors.topMargin: 5
        anchors.right: bkgItem.right
        anchors.bottom: bkgItem.bottom
        anchors.bottomMargin: 5
    }

}
