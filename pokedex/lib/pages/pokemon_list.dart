import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokedex.dart';
import 'package:pokedex/pages/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  var uri = Uri.parse(
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
  Pokedex pokedex;
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(uri);
    var decodedJson = json.decode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
      ),
      body: OrientationBuilder(
        //yatay ekran ayarı için
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return FutureBuilder(
                future: veri,
                builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    //işlem daha bitmemişse bunu yap
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState ==
                      ConnectionState.done) {
                    ////////////////////2. YOL///////////GridView.count/////////////////////////
                    return Container(
                      child: GridView.count(
                          crossAxisCount: 2,
                          children: gelenPokedex.data.pokemon.map((poke) {
                            var imge = poke.img.replaceAll("http", "https");
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PokemonDetail(pokemon: poke)));
                              },
                              child: Hero(
                                tag: imge,
                                child: Card(
                                  elevation: 6,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 120,
                                          child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/pokeLoad.gif",
                                              fit: BoxFit.contain,
                                              image: imge ??
                                                  "https://stackoverflow.com/does-not-exist.png%22%20type=%22image/png" //!buraya default url verilmeli
                                              ), //resim yüklenene kadar ekrana gif filan verir
                                        ),
                                      ),
                                      Text(
                                        poke.name,
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                    );
                  }
                });
          } else {
            return FutureBuilder(
                future: veri,
                builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
                  if (gelenPokedex.connectionState == ConnectionState.waiting) {
                    //işlen daha bitmemişse bunu yap
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (gelenPokedex.connectionState ==
                      ConnectionState.done) {
                    ////////////////////2. YOL///////////GridView.count/////////////////////////
                    return Container(
                      child: GridView.count(
                          crossAxisCount: 4,
                          children: gelenPokedex.data.pokemon.map((poke) {
                            var imge = poke.img.replaceAll("http", "https");
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        PokemonDetail(pokemon: poke)));
                              },
                              child: Hero(
                                tag: imge,
                                child: Card(
                                  elevation: 6,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 120,
                                          child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/pokeLoad.gif",
                                              fit: BoxFit.contain,
                                              image: imge ??
                                                  "https://stackoverflow.com/does-not-exist.png%22%20type=%22image/png" //!buraya default url verilmeli
                                              ),
                                        ),
                                      ),
                                      Text(
                                        poke.name,
                                        style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList()),
                    );
                  }
                });
          }
        },
      ),
    );
  }
}
