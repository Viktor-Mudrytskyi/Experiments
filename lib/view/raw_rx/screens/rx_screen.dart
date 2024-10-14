import 'package:experiments/core/core.dart';
import 'package:experiments/view/view.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class RxScreen extends StatefulWidget {
  const RxScreen({super.key});

  @override
  State<RxScreen> createState() => _RxScreenState();
}

class _RxScreenState extends State<RxScreen> {
  final PokemonRepo _pokemonRepo = getIt();

  late final PublishSubject<PokemonEvent> _eventSubject;
  late final BehaviorSubject<PokemonState> _stateSubject;

  @override
  void initState() {
    _stateSubject = BehaviorSubject<PokemonState>.seeded(const InitialPokemonState());
    _eventSubject = PublishSubject<PokemonEvent>();

    _eventSubject.listen(_mapEventToState);
    _initialLoad();

    super.initState();
  }

  @override
  void dispose() {
    _stateSubject.close();
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
              onPaginate: () {},
              onRefresh: _initialLoad,
            ),
          ErrorPokemonState() => Center(
              child: Column(
                children: [
                  Text((snapshot.data as ErrorPokemonState).error),
                  ElevatedButton(
                    onPressed: () {
                      _initialLoad();
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
      await _fetchPokemon(offset: event.offset, limit: event.limit);
      return;
    }
  }

  Future<void> _initialLoad() async {
    _stateSubject.sink.add(const LoadingPokemonState());
    await _fetchPokemon(offset: 0, limit: 30);
  }

  Future<void> _fetchPokemon({required int offset, required int limit}) async {
    try {
      final pokemon = await _pokemonRepo.getPokemons(
        offset: offset,
        limit: limit,
      );
      _stateSubject.sink.add(
        LoadedPokemonState(
          pokemon: pokemon,
          isPaginating: false,
        ),
      );
    } catch (e) {
      _stateSubject.sink.add(ErrorPokemonState(e.toString()));
    }
  }
}

class PokemonView extends StatelessWidget {
  const PokemonView({
    super.key,
    required this.pokemon,
    required this.onPaginate,
    required this.onRefresh,
  });

  final PokemonResponse pokemon;
  final void Function() onPaginate;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${pokemon.results?[index].name}',
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: pokemon.results?.length ?? 0,
      ),
    );
  }
}
