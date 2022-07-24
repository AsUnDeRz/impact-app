import 'package:app/generated/json/base/json_convert_content.dart';
import 'package:app/models/trainer_entity.dart';

TrainerEntity $TrainerEntityFromJson(Map<String, dynamic> json) {
  final TrainerEntity trainerEntity = TrainerEntity();
  final String? sId = jsonConvert.convert<String>(json['_id']);
  if (sId != null) {
    trainerEntity.sId = sId;
  }
  final String? email = jsonConvert.convert<String>(json['email']);
  if (email != null) {
    trainerEntity.email = email;
  }
  final String? firstName = jsonConvert.convert<String>(json['first_name']);
  if (firstName != null) {
    trainerEntity.firstName = firstName;
  }
  final String? lastName = jsonConvert.convert<String>(json['last_name']);
  if (lastName != null) {
    trainerEntity.lastName = lastName;
  }
  final String? avatar = jsonConvert.convert<String>(json['avatar']);
  if (avatar != null) {
    trainerEntity.avatar = avatar;
  }
  final int? iV = jsonConvert.convert<int>(json['__v']);
  if (iV != null) {
    trainerEntity.iV = iV;
  }
  return trainerEntity;
}

Map<String, dynamic> $TrainerEntityToJson(TrainerEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['_id'] = entity.sId;
  data['email'] = entity.email;
  data['first_name'] = entity.firstName;
  data['last_name'] = entity.lastName;
  data['avatar'] = entity.avatar;
  data['__v'] = entity.iV;
  return data;
}
