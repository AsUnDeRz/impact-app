import 'package:app/models/get_pokemon_entity.dart';
import 'package:equatable/equatable.dart';

enum PokemonStatus { initial, success, failure }

class PokemonState extends Equatable {
  const PokemonState(
      {this.status = PokemonStatus.initial,
      this.pokemons = const <GetPokemonEntity>[],
      this.hasReachedMax = false,
      this.currentPage = 1});

  final PokemonStatus status;
  final List<GetPokemonEntity> pokemons;
  final bool hasReachedMax;
  final int currentPage;

  PokemonState copyWith(
      {PokemonStatus? status,
      List<GetPokemonEntity>? pokemons,
      bool? hasReachedMax,
      int? currentPage}) {
    return PokemonState(
        status: status ?? this.status,
        pokemons: pokemons ?? this.pokemons,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  String toString() {
    return '''PokemonState { status: $status, hasReachedMax: $hasReachedMax, posts: ${pokemons.length} }''';
  }

  @override
  List<Object> get props => [status, pokemons, hasReachedMax];
}
