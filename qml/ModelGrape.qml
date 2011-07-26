import Qt 4.7

ListModel {
    id: mdlWine
    //TODO: how to handle translations?
    ListElement { name: "Merlot"; value: 1; selected: true }
    ListElement { name: "Cabernet Sauvignon"; value: 2; selected: false }
    ListElement { name: "Cabernet Sauvignon Blanc"; value: 3; selected: false }
    ListElement { name: "Pinot Noir"; value: 4; selected: false }
    ListElement { name: "Porto"; value: 5; selected: false }
    ListElement { name: "Multi"; value: 6; selected: false }
    ListElement { name: "Chiraz"; value: 7; selected: false }
    ListElement { name: "Malbec"; value: 8; selected: false }
    ListElement { name: "Chardornay"; value: 9; selected: false }
    ListElement { name: "Riesling"; value: 10; selected: false }
    ListElement { name: "Other"; value: 11; selected: false }
}
