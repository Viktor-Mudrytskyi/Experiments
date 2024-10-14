import 'package:dio/dio.dart';
import 'package:experiments/core/core.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;
Future<void> initDI() async {
  /// Managers, services

  /// Data

  // Unauthorised

  // Api

  final Dio client = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'))..interceptors.add(DioLogger());
  getIt.registerFactory(() => ApiClient(client: client));
  getIt.registerFactory(() => PokemonApi(apiClient: getIt()));

  // Repos

  getIt.registerFactory(() => PokemonRepo(pokemonApi: getIt()));

  // Authorised

  // Api

  // Repos

  /// View

  // Global (should only have one instance in the app lifecycle)

  // Local (should create new instance every time)
}
