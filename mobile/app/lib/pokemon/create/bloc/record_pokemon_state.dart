part of 'record_pokemon_bloc.dart';

enum RecordPokemonStatus { initial, loading, success, failure, removed }

class RecordPokemonState extends Equatable {
  const RecordPokemonState(
      {this.pokemon, this.status = RecordPokemonStatus.initial});

  final GetPokemonEntity? pokemon;
  final RecordPokemonStatus status;

  @override
  List<Object?> get props => [pokemon, status];

  RecordPokemonState copyWith({
    GetPokemonEntity? pokemonEntity,
    RecordPokemonStatus? status,
  }) {
    return RecordPokemonState(
        pokemon: pokemonEntity ?? this.pokemon, status: status ?? this.status);
  }
}
