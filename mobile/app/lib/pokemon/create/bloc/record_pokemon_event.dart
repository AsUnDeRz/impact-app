part of 'record_pokemon_bloc.dart';

abstract class RecordPokemonEvent extends Equatable {
  const RecordPokemonEvent();

  @override
  List<Object> get props => [];
}

class RecordPokemonCreated extends RecordPokemonEvent {
  final String name;
  final String imageUrl;

  const RecordPokemonCreated(this.name, this.imageUrl);
}

class RecordPokemonEdited extends RecordPokemonEvent {
  final GetPokemonEntity data;

  const RecordPokemonEdited(this.data);
}

class RecordPokemonRemoved extends RecordPokemonEvent {
  final GetPokemonEntity data;

  const RecordPokemonRemoved(this.data);
}

class RecordPokemonInit extends RecordPokemonEvent {
  final GetPokemonEntity data;

  const RecordPokemonInit(this.data);
}
