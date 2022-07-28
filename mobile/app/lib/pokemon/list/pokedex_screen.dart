import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/list/bloc/pokemon_bloc.dart';
import 'package:app/pokemon/list/bloc/pokemon_event.dart';
import 'package:app/pokemon/list/bloc/pokemon_state.dart';
import 'package:app/pokemon/list/ui/pokemon_list.dart';
import 'package:app/pokemon/repository/pokemon_repository.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonBloc(repository: PokemonRepository(http.Client()))
        ..add(PokemonFetched()),
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pokedex'),
              backgroundColor: const Color(0xffED1729),
            ),
            body: const PokemonList(),
            floatingActionButton: state.canScrollToTop == false
                ? FloatingActionButton(
                    backgroundColor: const Color(0xffED1729),
                    onPressed: () async {
                      final result = await AppNavigator.push(Routes.newPokedex);
                      if (result is GetPokemonEntity) {
                        context
                            .read<PokemonBloc>()
                            .add(PokemonRecorded(result));
                      }
                    },
                    child: const Icon(Icons.add),
                  )
                : FloatingActionButton(
                    onPressed: () {
                      context.read<PokemonBloc>().add(PokemonScrollToTop());
                    },
                    child: const Icon(Icons.arrow_upward),
                  ),
          );
        },
      ),
    );
  }
}
