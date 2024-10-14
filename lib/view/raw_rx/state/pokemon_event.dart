sealed class PokemonEvent {
  const PokemonEvent();
}

class LoadPokemonEvent extends PokemonEvent {
  const LoadPokemonEvent();
}

class PaginatePokemonEvent extends PokemonEvent {
  const PaginatePokemonEvent();
}
