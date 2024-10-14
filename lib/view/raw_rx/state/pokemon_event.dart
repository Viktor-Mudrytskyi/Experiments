sealed class PokemonEvent {
  const PokemonEvent();
}

class LoadPokemonEvent extends PokemonEvent {
  const LoadPokemonEvent({required this.offset, required this.limit});

  final int offset;
  final int limit;
}

class PaginatePokemonEvent extends PokemonEvent {
  const PaginatePokemonEvent({required this.offset, required this.limit});

  final int offset;
  final int limit;
}
