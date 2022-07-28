import 'package:app/bloc_observer_app.dart';
import 'package:app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: BlocObserverApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
    );
  }
}
