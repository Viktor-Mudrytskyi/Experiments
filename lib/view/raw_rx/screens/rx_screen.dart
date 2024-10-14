import 'package:experiments/core/core.dart';
import 'package:experiments/view/view.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/transformers.dart';

class RxScreen extends StatefulWidget {
  const RxScreen({super.key});

  @override
  State<RxScreen> createState() => _RxScreenState();
}

class _RxScreenState extends State<RxScreen> {
  final PokemonRepo _pokemonRepo = getIt();

  late final PublishSubject<PokemonEvent> _eventSubject;
  late final BehaviorSubject<PokemonState> _stateSubject;

  PokemonState get _state => _stateSubject.value;

  @override
  void initState() {
    _stateSubject = BehaviorSubject<PokemonState>.seeded(const InitialPokemonState());
    _eventSubject = PublishSubject<PokemonEvent>();

    _eventSubject.stream.throttleTime(const Duration(milliseconds: 600)).listen(_mapEventToState);
    _eventSubject.add(const LoadPokemonEvent());

    super.initState();
  }

  @override
  void dispose() {
    _stateSubject.close();
    _eventSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PokemonState>(
      stream: _stateSubject,
      builder: (context, snapshot) {
        return switch (snapshot.data) {
          InitialPokemonState() => const Center(child: CircularProgressIndicator()),
          LoadingPokemonState() => const Center(child: CircularProgressIndicator()),
          LoadedPokemonState() => PokemonView(
              pokemon: (snapshot.data as LoadedPokemonState).pokemon,
              onPaginate: () {
                _eventSubject.add(const PaginatePokemonEvent());
              },
              onRefresh: () async {
                _eventSubject.add(const LoadPokemonEvent());
              },
              isPaginating: (snapshot.data as LoadedPokemonState).isPaginating,
            ),
          ErrorPokemonState() => Center(
              child: Column(
                children: [
                  Text((snapshot.data as ErrorPokemonState).error),
                  ElevatedButton(
                    onPressed: () {
                      _eventSubject.add(const LoadPokemonEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          null => Container(),
        };
      },
    );
  }

  Future<void> _mapEventToState(PokemonEvent event) async {
    if (event is LoadPokemonEvent) {
      await _fetchPokemon();
      return;
    }

    if (event is PaginatePokemonEvent) {
      await _paginatePokemon();
      return;
    }
  }

  Future<void> _paginatePokemon() async {
    if (_state is! LoadedPokemonState) {
      return;
    }
    final loaded = _state as LoadedPokemonState;
    if (loaded.isAtEnd) {
      return;
    }
    final loadedPokemons = loaded.pokemon.results?.toList() ?? [];

    try {
      _stateSubject.sink.add(
        LoadedPokemonState(
          pokemon: loaded.pokemon,
          isPaginating: true,
          offset: loaded.offset,
          limit: loaded.limit,
          isAtEnd: loadedPokemons.length < loaded.limit,
        ),
      );
      final pokemon = await _pokemonRepo.getPokemons(
        offset: loaded.offset + loaded.limit,
        limit: loaded.limit,
      );
      loadedPokemons.addAll(pokemon.results ?? []);
      _stateSubject.sink.add(
        LoadedPokemonState(
          pokemon: pokemon.copyWith(results: () => loadedPokemons),
          isPaginating: false,
          offset: loaded.offset + 30,
          limit: loaded.limit,
          isAtEnd: pokemon.next == null,
        ),
      );
    } catch (e) {
      _stateSubject.sink.add(ErrorPokemonState(e.toString()));
    }
  }

  Future<void> _fetchPokemon() async {
    try {
      final pokemon = await _pokemonRepo.getPokemons(
        offset: 0,
        limit: 30,
      );
      _stateSubject.sink.add(
        LoadedPokemonState(
          pokemon: pokemon,
          isPaginating: false,
          offset: 0,
          limit: 30,
          isAtEnd: false,
        ),
      );
    } catch (e) {
      _stateSubject.sink.add(ErrorPokemonState(e.toString()));
    }
  }
}

class PokemonView extends StatefulWidget {
  const PokemonView({
    super.key,
    required this.pokemon,
    required this.onPaginate,
    required this.onRefresh,
    required this.isPaginating,
  });

  final PokemonResponse pokemon;
  final void Function() onPaginate;
  final Future<void> Function() onRefresh;
  final bool isPaginating;

  @override
  State<PokemonView> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController()..addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView(
        controller: _controller,
        children: [
          ...List.generate(
            widget.pokemon.results?.length ?? 0,
            (index) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.pokemon.results?[index].name}',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
              ],
            ),
          ),
          if (widget.isPaginating)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _listener() {
    if (!_controller.hasClients) {
      return;
    }
    if (_controller.offset >= _controller.position.maxScrollExtent * 0.8) {
      widget.onPaginate();
    }
  }
}
