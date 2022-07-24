import 'dart:convert';

import 'package:app/env_config.dart';
import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/bloc/pokemon_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'pokemon_event.dart';

const _postLimit = 10;

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc({required this.httpClient}) : super(const PokemonState()) {
    on<PokemonFetched>(_onPostFetched);
    on<PokemonPullToRefresh>(_onPullToRefresh);
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
    PokemonFetched event,
    Emitter<PokemonState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PokemonStatus.initial) {
        final pokemons = await _fetchPokemons();
        return emit(state.copyWith(
            status: PokemonStatus.success,
            pokemons: pokemons,
            hasReachedMax: false,
            currentPage: state.currentPage + 1));
      }
      final pokemons = await _fetchPokemons(state.currentPage);
      pokemons.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                  status: PokemonStatus.success,
                  pokemons: List.of(state.pokemons)..addAll(pokemons),
                  hasReachedMax: false,
                  currentPage: state.currentPage + 1),
            );
    } catch (error) {
      print(error);
      emit(state.copyWith(status: PokemonStatus.failure));
    }
  }

  Future<List<GetPokemonEntity>> _fetchPokemons([int startIndex = 1]) async {
    final response = await httpClient.get(
      Uri.http(
        ENDPOINT_API,
        '/api/pokemon/getAll',
        <String, String>{'page': "$startIndex", 'limit': "$_postLimit"},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return GetPokemonEntity.fromJson(json);
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<void> _onPullToRefresh(
    PokemonPullToRefresh event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      emit(state.copyWith(
          status: PokemonStatus.initial,
          pokemons: [],
          hasReachedMax: false,
          currentPage: 1));

      ///Beautiful load
      await Future.delayed(const Duration(seconds: 1));
      final pokemons = await _fetchPokemons();
      return emit(state.copyWith(
          status: PokemonStatus.success,
          pokemons: pokemons,
          hasReachedMax: false,
          currentPage: state.currentPage + 1));
    } catch (error) {
      emit(state.copyWith(status: PokemonStatus.failure));
    }
  }
}
