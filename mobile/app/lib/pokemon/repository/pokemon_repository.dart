import 'dart:convert';

import 'package:app/env_config.dart';
import 'package:app/models/get_pokemon_entity.dart';
import 'package:http/http.dart' as http;

class PokemonRepository {
  final http.Client httpClient;

  const PokemonRepository(this.httpClient);

  Future<List<GetPokemonEntity>> getPokemons(
      [int startIndex = 1, int limit = 10]) async {
    final response = await httpClient.get(
      Uri.http(
        ENDPOINT_API,
        '/api/pokemon/getAll',
        <String, String>{'page': "$startIndex", 'limit': "$limit"},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return GetPokemonEntity.fromJson(json);
      }).toList();
    }
    throw Exception('error fetching posts');
  }

  Future<GetPokemonEntity> newRecordPokemon(
      RequestCreatePokemonEntity data) async {
    final response = await httpClient.post(
        Uri.http(
          ENDPOINT_API,
          '/api/pokemon/collected',
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toJson()));
    if (response.statusCode == 200) {
      final result = GetPokemonEntity.fromJson(json.decode(response.body));
      return result;
    }
    throw Exception('error new record pokemon');
  }

  Future<GetPokemonEntity> editRecordPokemon(GetPokemonEntity data) async {
    final response = await httpClient.put(
        Uri.http(
          ENDPOINT_API,
          '/api/pokemon/update/${data.sId}',
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(data.toJson()));
    if (response.statusCode == 200) {
      final result = GetPokemonEntity.fromJson(json.decode(response.body));
      return result;
    }
    throw Exception('error edit record pokemon');
  }

  Future<bool> removeRecordPokemon(GetPokemonEntity data) async {
    final response = await httpClient.delete(Uri.http(
      ENDPOINT_API,
      '/api/pokemon/delete/${data.sId}',
    ));
    if (response.statusCode == 200) {
      return true;
    }
    throw Exception('error remove record pokemon');
  }
}
