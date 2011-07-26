import Qt 4.7

ListModel {
    id: mdlWine
    //TODO: how to handle translations?
    ListElement { name: "red"; value: 1; selected: true }
    ListElement { name: "white"; value: 2; selected: false }
    ListElement { name: "sparkling"; value: 3; selected: false }
    ListElement { name: "rose"; value: 4; selected: false }
    ListElement { name: "other"; value: 5; selected: false }
}
