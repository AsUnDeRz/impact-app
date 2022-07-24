import 'package:equatable/equatable.dart';

abstract class TrainerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TrainerVerified extends TrainerEvent {
  final String email;
  final String firstName;

  TrainerVerified(this.email, this.firstName);
}
