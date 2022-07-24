import 'package:app/pokemon/bloc/pokemon_bloc.dart';
import 'package:app/pokemon/bloc/pokemon_event.dart';
import 'package:app/pokemon/ui/pokemon_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        backgroundColor: const Color(0xffED1729),
      ),
      body: BlocProvider(
        create: (_) =>
            PokemonBloc(httpClient: http.Client())..add(PokemonFetched()),
        child: const PokemonList(),
      ),
    );
  }
}
