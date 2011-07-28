/*  Copyright (C) 2011  Adenilson Cavalcanti <cavalcantii@gmail.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; by version 2 of the License.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 *
 */

import Qt 4.7

ListModel {
    ListElement {
        //Visible in first level
        name: "Casillero Del Diablo"; grape: "Cabernet Sauvignon";
        type: 0; //red
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

    ListElement { name: "Santa Helena"; grape: "Merlot";
        type: 1; //white
        producer: "Vinos Del Castilho"; region: "Valle de Tulum";
        year: "2009"; price: 30;
        tasting: "Nutty flavor with great after taste and some blueberries
                  and cinamon touches";
        picture: "imgs/wine01.png"

    }

    ListElement { name: "Old Oak napa"; grape: "Pinot Noir";
        type: 3; //other
        producer: "Vinos Del Castilho"; region: "Valle de Tulum";
        year: "2011"; price: 30;
        tasting: "Nutty flavor with great after taste and some blueberries
                  and cinamon touches";
        picture: "imgs/wine01.png"

    }
}
