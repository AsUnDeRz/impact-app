import 'package:app/generated/json/base/json_convert_content.dart';
import 'package:app/models/get_pokemon_entity.dart';

GetPokemonEntity $GetPokemonEntityFromJson(Map<String, dynamic> json) {
  final GetPokemonEntity getPokemonEntity = GetPokemonEntity();
  final String? sId = jsonConvert.convert<String>(json['_id']);
  if (sId != null) {
    getPokemonEntity.sId = sId;
  }
  final double? id = jsonConvert.convert<double>(json['id']);
  if (id != null) {
    getPokemonEntity.id = id;
  }
  final String? num = jsonConvert.convert<String>(json['num']);
  if (num != null) {
    getPokemonEntity.num = num;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getPokemonEntity.name = name;
  }
  final String? img = jsonConvert.convert<String>(json['img']);
  if (img != null) {
    getPokemonEntity.img = img;
  }
  final List<String>? type =
      jsonConvert.convertListNotNull<String>(json['type']);
  if (type != null) {
    getPokemonEntity.type = type;
  }
  final String? height = jsonConvert.convert<String>(json['height']);
  if (height != null) {
    getPokemonEntity.height = height;
  }
  final String? weight = jsonConvert.convert<String>(json['weight']);
  if (weight != null) {
    getPokemonEntity.weight = weight;
  }
  final String? candy = jsonConvert.convert<String>(json['candy']);
  if (candy != null) {
    getPokemonEntity.candy = candy;
  }
  final String? egg = jsonConvert.convert<String>(json['egg']);
  if (egg != null) {
    getPokemonEntity.egg = egg;
  }
  final List<double>? multipliers =
      jsonConvert.convertListNotNull<double>(json['multipliers']);
  if (multipliers != null) {
    getPokemonEntity.multipliers = multipliers;
  }
  final List<String>? weaknesses =
      jsonConvert.convertListNotNull<String>(json['weaknesses']);
  if (weaknesses != null) {
    getPokemonEntity.weaknesses = weaknesses;
  }
  final double? candyCount = jsonConvert.convert<double>(json['candy_count']);
  if (candyCount != null) {
    getPokemonEntity.candyCount = candyCount;
  }
  final double? spawnChance = jsonConvert.convert<double>(json['spawn_chance']);
  if (spawnChance != null) {
    getPokemonEntity.spawnChance = spawnChance;
  }
  final double? avgSpawns = jsonConvert.convert<double>(json['avg_spawns']);
  if (avgSpawns != null) {
    getPokemonEntity.avgSpawns = avgSpawns;
  }
  final String? spawnTime = jsonConvert.convert<String>(json['spawn_time']);
  if (spawnTime != null) {
    getPokemonEntity.spawnTime = spawnTime;
  }
  final List<GetPokemonPrevEvolution>? prevEvolution = jsonConvert
      .convertListNotNull<GetPokemonPrevEvolution>(json['prev_evolution']);
  if (prevEvolution != null) {
    getPokemonEntity.prevEvolution = prevEvolution;
  }
  final List<GetPokemonNextEvolution>? nextEvolution = jsonConvert
      .convertListNotNull<GetPokemonNextEvolution>(json['next_evolution']);
  if (nextEvolution != null) {
    getPokemonEntity.nextEvolution = nextEvolution;
  }
  return getPokemonEntity;
}

Map<String, dynamic> $GetPokemonEntityToJson(GetPokemonEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['_id'] = entity.sId;
  data['id'] = entity.id;
  data['num'] = entity.num;
  data['name'] = entity.name;
  data['img'] = entity.img;
  data['type'] = entity.type;
  data['height'] = entity.height;
  data['weight'] = entity.weight;
  data['candy'] = entity.candy;
  data['egg'] = entity.egg;
  data['multipliers'] = entity.multipliers;
  data['weaknesses'] = entity.weaknesses;
  data['candy_count'] = entity.candyCount;
  data['spawn_chance'] = entity.spawnChance;
  data['avg_spawns'] = entity.avgSpawns;
  data['spawn_time'] = entity.spawnTime;
  data['prev_evolution'] =
      entity.prevEvolution?.map((v) => v.toJson()).toList();
  data['next_evolution'] =
      entity.nextEvolution?.map((v) => v.toJson()).toList();
  return data;
}

GetPokemonPrevEvolution $GetPokemonPrevEvolutionFromJson(
    Map<String, dynamic> json) {
  final GetPokemonPrevEvolution getPokemonPrevEvolution =
      GetPokemonPrevEvolution();
  final String? num = jsonConvert.convert<String>(json['num']);
  if (num != null) {
    getPokemonPrevEvolution.num = num;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getPokemonPrevEvolution.name = name;
  }
  return getPokemonPrevEvolution;
}

Map<String, dynamic> $GetPokemonPrevEvolutionToJson(
    GetPokemonPrevEvolution entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['num'] = entity.num;
  data['name'] = entity.name;
  return data;
}

GetPokemonNextEvolution $GetPokemonNextEvolutionFromJson(
    Map<String, dynamic> json) {
  final GetPokemonNextEvolution getPokemonNextEvolution =
      GetPokemonNextEvolution();
  final String? num = jsonConvert.convert<String>(json['num']);
  if (num != null) {
    getPokemonNextEvolution.num = num;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    getPokemonNextEvolution.name = name;
  }
  return getPokemonNextEvolution;
}

Map<String, dynamic> $GetPokemonNextEvolutionToJson(
    GetPokemonNextEvolution entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['num'] = entity.num;
  data['name'] = entity.name;
  return data;
}
