import 'package:flutter/material.dart';
import 'package:pokedex/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk = Colors.blue.shade200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    var imge = widget.pokemon.img.replaceAll("http", "https");
    Future<PaletteGenerator> fPaletteGenerator =
        PaletteGenerator.fromImageProvider(
      NetworkImage(imge),
    );

    fPaletteGenerator.then((value) {
      paletteGenerator = value;
      debugPrint(
          "Seçilen Renk" + paletteGenerator.dominantColor.color.toString());
      setState(() {
        baskinRenk = paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var imge = widget.pokemon.img.replaceAll("http", "https");
    return Scaffold(
        backgroundColor: baskinRenk,
        appBar: AppBar(
          backgroundColor: baskinRenk,
          elevation: 0,
          title: Text(
            widget.pokemon.name,
            textAlign: TextAlign.center,
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return dikeyBody(context, imge);
          } else {
            return yatayBody(context, imge);
          }
        }));
  }

  Widget yatayBody(BuildContext context, String imge) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height * (3 / 4),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 200,
                child: Image.network(imge, fit: BoxFit.fill),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        //listelerle çalısıyorsak aklımıza "map" yapısı gelmeli.
                        //listenin herbir elemanını al birer Chip widget ine dönüştür sonrasında children list beklediği için tolist direyek listeye dönüştürdük
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
                        : [Text("Son Hali")],
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
        ],
      ),
    );
  }

  Stack dikeyBody(BuildContext context, String imge) {
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
                      //listelerle çalısıyorsak aklımıza "map" yapısı gelmeli.
                      //listenin herbir elemanını al birer Chip widget ine dönüştür sonrasında children list beklediği için tolist direyek listeye dönüştürdük
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
              child: Image.network(imge, fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }
}
