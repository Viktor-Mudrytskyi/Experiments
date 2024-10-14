import 'package:experiments/core/core.dart';

class PokemonRepo {
  PokemonRepo({required PokemonApi pokemonApi}) : _pokemonApi = pokemonApi;

  final PokemonApi _pokemonApi;

  Future<PokemonResponse> getPokemons({
    required int offset,
    required int limit,
  }) async {
    final response = await _pokemonApi.getPokemons(
      offset: offset,
      limit: limit,
    );
    return PokemonResponse.fromJson(response);
  }
}
