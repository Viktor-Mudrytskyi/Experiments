import 'package:experiments/core/core.dart';

class PokemonResponse {
  PokemonResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    return PokemonResponse(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List).map((result) => PokemonModel.fromJson(result as Map<String, dynamic>)).toList(),
    );
  }

  final int? count;
  final String? next;
  final String? previous;
  final List<PokemonModel>? results;

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results?.map((result) => result.toJson()).toList(),
    };
  }
}
