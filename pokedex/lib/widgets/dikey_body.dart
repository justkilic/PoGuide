import 'package:flutter/material.dart';
import 'package:pokedex/models/pokedex.dart';

class DikeyBody extends StatefulWidget {
  final Pokemon pokemon;
  final String imge;

  DikeyBody({Key key, this.pokemon, this.imge});

  @override
  _DikeyBodyState createState() => _DikeyBodyState();
}

class _DikeyBodyState extends State<DikeyBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * (7 / 10),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top:
              MediaQuery.of(context).size.height * 0.1, // yüksekliğin 10 da 1 i
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              //kenarları yumuşatılmış
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 50),
                Text(
                  widget.pokemon.name,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Boy :" + widget.pokemon.height,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Kilo :" + widget.pokemon.weight,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Güç",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type
                      .map((tip) => Chip(
                          backgroundColor: Colors.deepOrange.shade300,
                          label: Text(
                            tip,
                            style: TextStyle(color: Colors.white),
                          )))
                      .toList(), //telefondaki yeri grass poison
                ),
                Text(
                  "Evrim",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                          .map((evolution) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                evolution.name,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList()
                      : [Text("Doğum Hali")],
                ),
                Text(
                  "Sonraki Evrim",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((evolution) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                evolution.name,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList()
                      : [Text("Son Evrim")],
                ),
                Text(
                  "Zayıflık",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((weakness) => Chip(
                              backgroundColor: Colors.deepOrange.shade300,
                              label: Text(
                                weakness,
                                style: TextStyle(color: Colors.white),
                              )))
                          .toList()
                      : [Text("Zayıflığı Yok")],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(widget.imge, fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }
}
