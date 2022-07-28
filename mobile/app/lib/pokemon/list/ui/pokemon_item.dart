import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/list/bloc/pokemon_bloc.dart';
import 'package:app/pokemon/list/bloc/pokemon_event.dart';
import 'package:app/pokemon/list/bloc/pokemon_state.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final GetPokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
      return InkWell(
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Hero(
                    tag: pokemon.sId ?? '',
                    child: Image.network(pokemon.img ?? ''),
                  )),
                  Text(pokemon.name ?? ''),
                  Text(pokemon.num ?? '')
                ],
              ),
            ],
          ),
          foregroundDecoration: pokemon.newPokemon == true
              ? const RotatedCornerDecoration(
                  geometry: BadgeGeometry(width: 48, height: 48),
                  textSpan: TextSpan(
                    text: 'New',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        BoxShadow(color: Colors.yellowAccent, blurRadius: 10)
                      ],
                    ),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [Colors.purpleAccent, Colors.blue],
                  ))
              : null,
        ),
        onTap: () async {
          final result = await AppNavigator.push(Routes.pokemonInfo, pokemon);
          if (result is GetPokemonEntity) {
            context.read<PokemonBloc>().add(PokemonUpdateRecorded(result));
          }
          if (result == 'remove') {
            context.read<PokemonBloc>().add(PokemonRemoveRecorded(pokemon));
          }
        },
        onDoubleTap: () {},
      );
    });
  }
}
