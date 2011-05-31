import Qt 4.7

ListModel {
    ListElement {
        //Visible in first level
        name: "Casillero Del Diablo"; type: "Cabernet Sauvignon";
        kind: 0; //red
        producer: "Vinos Del Castilho"; region: "Valle de Tulum";
        year: "2007"; price: 30;
        tasting: "Nutty flavor with great after taste and some blueberries
                  and cinamon touches";
        picture: "imgs/wine01.png"
        //Second level
        comments: "They got it right this time"; comparisons: "Old Engine Oil";
        location: "Vilhena"; date: "17-02-2011"; rating: 5;
        //Third level
        photo1: "path/to/bottle"; photo2: "path/to/glass"

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
