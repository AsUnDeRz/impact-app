import 'dart:async';

import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/repository/pokemon_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'record_pokemon_event.dart';
part 'record_pokemon_state.dart';

class RecordPokemonBloc extends Bloc<RecordPokemonEvent, RecordPokemonState> {
  RecordPokemonBloc({required this.repository})
      : super(const RecordPokemonState()) {
    on<RecordPokemonCreated>(_onRecordPokemonCreated);
    on<RecordPokemonEdited>(_onRecordPokemonEdited);
    on<RecordPokemonRemoved>(_onRecordPokemonRemoved);
    on<RecordPokemonInit>(_onRecordPokemonInit);
  }

  final PokemonRepository repository;

  Future<void> _onRecordPokemonCreated(
    RecordPokemonCreated event,
    Emitter<RecordPokemonState> emit,
  ) async {
    final result = await repository
        .newRecordPokemon(generateDataFromPokeball(event.name, event.imageUrl));
    if (result.sId != null) {
      emit(state.copyWith(
          status: RecordPokemonStatus.success, pokemonEntity: result));
    }
  }

  RequestCreatePokemonEntity generateDataFromPokeball(String name, String img) {
    return RequestCreatePokemonEntity()
      ..id = 152
      ..num = "152"
      ..name = name
      ..img = img
      ..type = []
      ..height = ""
      ..weight = ""
      ..candy = ''
      ..egg = ''
      ..multipliers = []
      ..weaknesses = []
      ..candyCount = 0
      ..spawnChance = 0
      ..avgSpawns = 0
      ..spawnTime = ''
      ..nextEvolution = []
      ..prevEvolution = [];
  }

  Future<void> _onRecordPokemonEdited(
    RecordPokemonEdited event,
    Emitter<RecordPokemonState> emit,
  ) async {
    final result = await repository.editRecordPokemon(event.data);
    if (result.sId != null) {
      emit(state.copyWith(
          status: RecordPokemonStatus.success, pokemonEntity: result));
    }
  }

  FutureOr<void> _onRecordPokemonInit(
      RecordPokemonInit event, Emitter<RecordPokemonState> emit) async {
    emit(state.copyWith(
        status: RecordPokemonStatus.initial, pokemonEntity: event.data));
  }

  FutureOr<void> _onRecordPokemonRemoved(
      RecordPokemonRemoved event, Emitter<RecordPokemonState> emit) async {
    final result = await repository.removeRecordPokemon(event.data);
    if (result) {
      emit(state.copyWith(status: RecordPokemonStatus.removed));
    }
  }
}
