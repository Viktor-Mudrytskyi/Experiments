import 'package:experiments/core/data/pokemon/models/pokemon_response.dart';

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
  });
  final PokemonResponse pokemon;
  final bool isPaginating;
}

class ErrorPokemonState extends PokemonState {
  const ErrorPokemonState(this.error);

  final String error;
}
