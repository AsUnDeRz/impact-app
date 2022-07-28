import 'dart:convert';

import 'package:app/env_config.dart';
import 'package:app/models/trainer_entity.dart';
import 'package:app/routes.dart';
import 'package:app/trainer/bloc/trainer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'trainer_event.dart';

class TrainerBloc extends Bloc<TrainerEvent, TrainerState> {
  TrainerBloc({required this.httpClient}) : super(const TrainerState()) {
    on<TrainerVerified>(_onTrainerVerified);
  }

  final http.Client httpClient;

  Future<void> _onTrainerVerified(
    TrainerVerified event,
    Emitter<TrainerState> emit,
  ) async {
    try {
      await _verifyTrainer(event.email, event.firstName);
      emit(state.copyWith(status: TrainerStatus.success));
      await AppNavigator.replaceWith(Routes.pokedex);
      emit(state.copyWith(status: TrainerStatus.initial));
    } catch (error) {
      emit(state.copyWith(status: TrainerStatus.failure));
    }
  }

  Future<TrainerEntity> _verifyTrainer(String email, String firstName) async {
    final response = await httpClient.post(
        Uri.http(
          ENDPOINT_API,
          '/api/user/verify',
        ),
        body: {'email': email, 'first_name': firstName});
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return TrainerEntity.fromJson(body);
    }
    throw Exception('error verify trainer');
  }
}
