import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PokemonFetched extends PokemonEvent {}

class PokemonPullToRefresh extends PokemonEvent {}
