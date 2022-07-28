import 'package:app/models/get_pokemon_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonFetched extends PokemonEvent {}

class PokemonPullToRefresh extends PokemonEvent {}

class PokemonScrollToTop extends PokemonEvent {}

class PokemonCanScrollToTop extends PokemonEvent {
  final bool canScrollToTop;

  PokemonCanScrollToTop(this.canScrollToTop);
}

class PokemonRecorded extends PokemonEvent {
  final GetPokemonEntity data;

  PokemonRecorded(this.data);
}

class PokemonUpdateRecorded extends PokemonEvent {
  final GetPokemonEntity data;

  PokemonUpdateRecorded(this.data);
}

class PokemonRemoveRecorded extends PokemonEvent {
  final GetPokemonEntity data;

  PokemonRemoveRecorded(this.data);
}
