import 'package:app/core/fade_route.dart';
import 'package:app/pokemon/ui/pokedex_screen.dart';
import 'package:app/trainer/ui/trainer_screen.dart';
import 'package:flutter/material.dart';

enum Routes { splash, home, pokedex, pokemonInfo, typeEffects, items }

class _Paths {
  static const String trainer = '/home';
  static const String pokedex = '/home/pokedex';

  static const Map<Routes, String> _pathMap = {
    Routes.home: _Paths.trainer,
    Routes.pokedex: _Paths.pokedex,
  };

  static String of(Routes route) => _pathMap[route] ?? _Paths.trainer;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.pokedex:
        return FadeRoute(page: const PokedexScreen());
      default:
        return FadeRoute(page: const TrainerScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
