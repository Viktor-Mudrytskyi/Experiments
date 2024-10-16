class PokemonModel {
  PokemonModel({
    this.name,
    this.url,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );
  }
  final String? name;
  final String? url;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}
