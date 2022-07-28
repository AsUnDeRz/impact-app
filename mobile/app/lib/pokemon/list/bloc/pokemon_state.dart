import 'package:app/models/get_pokemon_entity.dart';
import 'package:equatable/equatable.dart';

enum PokemonStatus { initial, success, failure, scrollToTop, updateInfo }

class PokemonState extends Equatable {
  const PokemonState(
      {this.status = PokemonStatus.initial,
      this.pokemons = const <GetPokemonEntity>[],
      this.hasReachedMax = false,
      this.currentPage = 1,
      this.canScrollToTop = false});

  final PokemonStatus status;
  final List<GetPokemonEntity> pokemons;
  final bool hasReachedMax;
  final int currentPage;
  final bool canScrollToTop;

  PokemonState copyWith(
      {PokemonStatus? status,
      List<GetPokemonEntity>? pokemons,
      bool? hasReachedMax,
      int? currentPage,
      bool? canScrollToTop}) {
    return PokemonState(
        status: status ?? this.status,
        pokemons: pokemons ?? this.pokemons,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        currentPage: currentPage ?? this.currentPage,
        canScrollToTop: canScrollToTop ?? this.canScrollToTop);
  }

  @override
  String toString() {
    return '''PokemonState { canScrollToTop: $canScrollToTop,  status: $status, hasReachedMax: $hasReachedMax, posts: ${pokemons.length} }''';
  }

  @override
  List<Object> get props =>
      [status, pokemons, hasReachedMax, currentPage, canScrollToTop];
}
