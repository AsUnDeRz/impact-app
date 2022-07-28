import 'package:app/core/fade_route.dart';
import 'package:app/models/get_pokemon_entity.dart';
import 'package:app/pokemon/create/new_record_pokedex_screen.dart';
import 'package:app/pokemon/list/pokedex_info_screen.dart';
import 'package:app/pokemon/list/pokedex_screen.dart';

import 'package:app/trainer/ui/trainer_screen.dart';
import 'package:flutter/material.dart';

enum Routes { splash, home, pokedex, newPokedex, pokemonInfo }

class _Paths {
  static const String trainer = '/home';
  static const String pokedex = '/home/pokedex';
  static const String newPokedex = '/new/pokedex';
  static const String pokemonInfo = '/pokemon/info';

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.trainer,
    Routes.pokedex: _Paths.pokedex,
    Routes.newPokedex: _Paths.newPokedex,
    Routes.pokemonInfo: _Paths.pokemonInfo
  };

  static String of(Routes route) => _pathMap[route] ?? _Paths.trainer;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.pokedex:
        return FadeRoute(page: const PokedexScreen());
      case _Paths.newPokedex:
        return FadeRoute(page: const NewRecordPokedexScreen());
      case _Paths.trainer:
        return FadeRoute(page: const TrainerScreen());
      case _Paths.pokemonInfo:
        return FadeRoute(
            page: PokedexInfoScreen(
          pokemon: settings.arguments as GetPokemonEntity,
        ));
      default:
        return FadeRoute(page: const TrainerScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop([arguments]) => state?.pop(arguments);

  static NavigatorState? get state => navigatorKey.currentState;
}
