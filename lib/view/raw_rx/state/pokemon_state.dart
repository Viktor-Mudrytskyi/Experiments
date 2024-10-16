import 'package:experiments/data/pokemon/models/pokemon_response.dart';

sealed class PokemonState {
  const PokemonState();
}

class InitialPokemonState extends PokemonState {
  const InitialPokemonState();
}

class LoadingPokemonState extends PokemonState {
  const LoadingPokemonState();
}

class LoadedPokemonState extends PokemonState {
  const LoadedPokemonState({
    required this.pokemon,
    required this.isPaginating,
    required this.offset,
    required this.limit,
    required this.isAtEnd,
  });
  final PokemonResponse pokemon;
  final bool isPaginating;
  final int offset;
  final int limit;
  final bool isAtEnd;
}

class ErrorPokemonState extends PokemonState {
  const ErrorPokemonState(this.error);

  final String error;
}
