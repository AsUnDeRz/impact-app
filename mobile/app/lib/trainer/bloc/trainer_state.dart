import 'package:app/models/get_pokemon_entity.dart';
import 'package:equatable/equatable.dart';

enum TrainerStatus { initial, success, failure }

class TrainerState extends Equatable {
  const TrainerState({this.status = TrainerStatus.initial});

  final TrainerStatus status;

  TrainerState copyWith({TrainerStatus? status}) {
    return TrainerState(status: status ?? this.status);
  }

  @override
  String toString() {
    return '''TrainerState { status: $status} }''';
  }

  @override
  List<Object> get props => [status];
}
