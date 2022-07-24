import 'package:app/generated/json/base/json_field.dart';
import 'package:app/generated/json/trainer_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class TrainerEntity {
  @JSONField(name: "_id")
  String? sId;
  String? email;
  @JSONField(name: "first_name")
  String? firstName;
  @JSONField(name: "last_name")
  String? lastName;
  String? avatar;
  @JSONField(name: "__v")
  int? iV;

  TrainerEntity();

  factory TrainerEntity.fromJson(Map<String, dynamic> json) =>
      $TrainerEntityFromJson(json);

  Map<String, dynamic> toJson() => $TrainerEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
