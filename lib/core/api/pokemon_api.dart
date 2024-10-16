import 'package:experiments/core/core.dart';

class PokemonApi {
  PokemonApi({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getPokemons({
    required int offset,
    required int limit,
  }) async {
    final response = await _apiClient.request(
      method: ApiMethods.get,
      path: '/pokemon',
      queryParameters: {
        'offset': offset,
        'limit': limit,
      },
    ) as Map<String, dynamic>;
    return response;
  }
}
