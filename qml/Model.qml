import Qt 4.7

ListModel {
    ListElement { name: "Casillero Del Diablo"; type: "Cabernet Sauvignon";
        kind: 0; //red
        producer: "Vinos Del Castilho"; region: "Valle de Tulum";
        year: "2007"; price: 30;
        tasting: "Nutty flavor with great after taste and some blueberries
                  and cinamon touches";
        picture: "imgs/wine01.png"

    }

    ListElement { name: "Santa Helena"; type: "Merlot";
        kind: 1; //white
        producer: "Vinos Del Castilho"; region: "Valle de Tulum";
        year: "2009"; price: 30;
        tasting: "Nutty flavor with great after taste and some blueberries
                  and cinamon touches";
        picture: "imgs/wine01.png"

    }

    ListElement { name: "Old Oak napa"; type: "Pinot Noir";
        kind: 3; //other
        producer: "Vinos Del Castilho"; region: "Valle de Tulum";
        year: "2011"; price: 30;
        tasting: "Nutty flavor with great after taste and some blueberries
                  and cinamon touches";
        picture: "imgs/wine01.png"

    }
}
