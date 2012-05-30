import QtQuick 1.0

Rectangle {
    id: wdgMenu
    opacity: 0.8
    color: "#000"
    width: 180
    height: 355
    radius: 15

    signal languageSelected(string locale)

    ListView {
        anchors { top: parent.top; left: parent.left;
        right: parent.right; bottom: parent.bottom;
        topMargin: 30}
        model: ListModel {
            ListElement { language: "Portugues"; locale: "pt_BR" }
            ListElement { language: "Deutch"; locale: "de_DE" }
            ListElement { language: "Francais"; locale: "fr_FR" }
            ListElement { language: "Espanol"; locale: "es_ES" }
            ListElement { language: "Italiano"; locale: "it_IT" }
            ListElement { language: "English"; locale: "en_US" }
        }

        orientation: ListView.Vertical
        delegate: Text {
            anchors { left: parent.left; right: parent.right; leftMargin: 50 }
            height: 60; width: 170
            text: language
            font.weight: "Bold"
            font.capitalization: Font.Capitalize
            font.pixelSize:  18
            color: "#FFF"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Choosen: " + locale)
                    wdgMenu.languageSelected(locale)
                }
            }
        }
    }
}
