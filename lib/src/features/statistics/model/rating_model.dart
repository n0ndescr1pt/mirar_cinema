class RatingModel {
  final String nameRu;
  final String nameEn;
  final double rating;
  final int kinopoiskId;
  final DateTime createdAt;

  RatingModel({
    required this.nameRu,
    required this.nameEn,
    required this.rating,
    required this.kinopoiskId,
    required this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      nameRu: json['nameRu'] as String,
      nameEn: json['nameEn'] as String,
      rating: (json['rating'] as num).toDouble(),
      kinopoiskId: json['kinopoiskId'] as int,
      createdAt: DateTime.parse(json['createdAt']["iso"] as String),
    );
  }
}
