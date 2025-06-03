class WatchedModel {
  final String nameRu;
  final String nameEn;
  final List<dynamic> genre;
  final int kinopoiskId;
  final DateTime createdAt;

  WatchedModel({
    required this.nameRu,
    required this.nameEn,
    required this.genre,
    required this.kinopoiskId,
    required this.createdAt,
  });

  factory WatchedModel.fromJson(Map<String, dynamic> json) {
    return WatchedModel(
      nameRu: json['nameRu'] as String,
      nameEn: json['nameEn'] as String,
      genre: json['genre'] as List<dynamic>,
      kinopoiskId: json['kinopoiskId'] as int,
      createdAt: DateTime.parse(json['createdAt']["iso"] as String),
    );
  }
}
