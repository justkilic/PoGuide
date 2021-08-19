import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/pokedex.dart';
import 'package:pokedex/widgets/yatay_body.dart';
import '../widgets/dikey_body.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetail({this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk = Colors.blue.shade200;

  @override
  void initState() {
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
            return DikeyBody(imge: imge, pokemon: widget.pokemon);
          } else {
            return YatayBody(imge: imge, pokemon: widget.pokemon);
          }
        }));
  }
}
