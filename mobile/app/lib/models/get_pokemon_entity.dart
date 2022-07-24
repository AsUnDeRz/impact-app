import 'package:app/generated/json/base/json_field.dart';
import 'package:app/generated/json/get_pokemon_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class GetPokemonEntity {
  @JSONField(name: "_id")
  String? sId;
  double? id;
  String? num;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? weight;
  String? candy;
  String? egg;
  List<double>? multipliers;
  List<String>? weaknesses;
  @JSONField(name: "candy_count")
  double? candyCount;
  @JSONField(name: "spawn_chance")
  double? spawnChance;
  @JSONField(name: "avg_spawns")
  double? avgSpawns;
  @JSONField(name: "spawn_time")
  String? spawnTime;
  @JSONField(name: "prev_evolution")
  List<GetPokemonPrevEvolution>? prevEvolution;
  @JSONField(name: "next_evolution")
  List<GetPokemonNextEvolution>? nextEvolution;

  GetPokemonEntity();

  factory GetPokemonEntity.fromJson(Map<String, dynamic> json) =>
      $GetPokemonEntityFromJson(json);

  Map<String, dynamic> toJson() => $GetPokemonEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class GetPokemonPrevEvolution {
  String? num;
  String? name;

  GetPokemonPrevEvolution();

  factory GetPokemonPrevEvolution.fromJson(Map<String, dynamic> json) =>
      $GetPokemonPrevEvolutionFromJson(json);

  Map<String, dynamic> toJson() => $GetPokemonPrevEvolutionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class GetPokemonNextEvolution {
  String? num;
  String? name;

  GetPokemonNextEvolution();

  factory GetPokemonNextEvolution.fromJson(Map<String, dynamic> json) =>
      $GetPokemonNextEvolutionFromJson(json);

  Map<String, dynamic> toJson() => $GetPokemonNextEvolutionToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
