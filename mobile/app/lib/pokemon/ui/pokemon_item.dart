import 'package:app/models/get_pokemon_entity.dart';
import 'package:flutter/material.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final GetPokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          Image.network(pokemon.img ?? ''),
          Text(pokemon.name ?? ''),
          Text(pokemon.num ?? '')
        ],
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8))),
    );
  }
}
