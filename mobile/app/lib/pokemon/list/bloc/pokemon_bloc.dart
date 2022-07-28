import 'dart:async';
import 'dart:convert';

import 'package:app/env_config.dart';
import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/repository/pokemon_repository.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

import 'pokemon_event.dart';
import 'pokemon_state.dart';

const _limit = 10;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc({required this.repository}) : super(const PokemonState()) {
    on<PokemonFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PokemonPullToRefresh>(_onPullToRefresh);
    on<PokemonScrollToTop>(_onScrollToTop);
    on<PokemonCanScrollToTop>(_onCanScrollToTop);
    on<PokemonUpdateRecorded>(_onPokemonUpdateRecorded);
    on<PokemonRemoveRecorded>(_onPokemonRemoveRecorded);
    on<PokemonRecorded>(_onPokemonRecorded);
  }

  final PokemonRepository repository;

  Future<void> _onPostFetched(
    PokemonFetched event,
    Emitter<PokemonState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PokemonStatus.initial) {
        final pokemons = await repository.getPokemons(1, _limit);
        return emit(state.copyWith(
            status: PokemonStatus.success,
            pokemons: pokemons,
            hasReachedMax: false,
            currentPage: state.currentPage + 1));
      }
      final pokemons = await repository.getPokemons(state.currentPage, _limit);
      pokemons.isEmpty
          ? emit(state.copyWith(
              hasReachedMax: true,
            ))
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
      final pokemons = await repository.getPokemons(1, _limit);
      return emit(state.copyWith(
          status: PokemonStatus.success,
          pokemons: pokemons,
          hasReachedMax: false,
          currentPage: state.currentPage + 1));
    } catch (error) {
      emit(state.copyWith(status: PokemonStatus.failure));
    }
  }

  Future<void> _onScrollToTop(
    PokemonScrollToTop event,
    Emitter<PokemonState> emit,
  ) async {
    emit(state.copyWith(status: PokemonStatus.scrollToTop));
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: PokemonStatus.success));
  }

  Future<void> _onCanScrollToTop(
    PokemonCanScrollToTop event,
    Emitter<PokemonState> emit,
  ) async {
    if (state.canScrollToTop != event.canScrollToTop) {
      emit(state.copyWith(canScrollToTop: event.canScrollToTop));
    }
  }

  FutureOr<void> _onPokemonUpdateRecorded(
      PokemonUpdateRecorded event, Emitter<PokemonState> emit) {
    print('_onPokemonUpdateRecorded ');
    emit(state.copyWith(status: PokemonStatus.updateInfo));
    final indexOf =
        state.pokemons.indexWhere((element) => element.sId == event.data.sId);
    state.pokemons[indexOf].name = event.data.name;
    emit(state.copyWith(
        pokemons: List.of(state.pokemons), status: PokemonStatus.success));
  }

  FutureOr<void> _onPokemonRemoveRecorded(
      PokemonRemoveRecorded event, Emitter<PokemonState> emit) async {
    emit(state.copyWith(status: PokemonStatus.updateInfo));
    state.pokemons.removeWhere((element) => element.sId == event.data.sId);
    emit(state.copyWith(
        pokemons: List.of(state.pokemons), status: PokemonStatus.success));
  }

  FutureOr<void> _onPokemonRecorded(
      PokemonRecorded event, Emitter<PokemonState> emit) {
    emit(state.copyWith(status: PokemonStatus.updateInfo));
    state.pokemons.insert(
        0, GetPokemonEntity.fromJson(event.data.toJson())..newPokemon = true);
    emit(state.copyWith(
        pokemons: List.of(state.pokemons), status: PokemonStatus.success));
  }
}
