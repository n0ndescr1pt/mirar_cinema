import 'package:json_annotation/json_annotation.dart';

part 'detail_dto.g.dart';

@JsonSerializable()
class DetailDTO {
  @JsonKey(name: 'kinopoiskId')
  final int kinopoiskId;
  @JsonKey(name: 'kinopoiskHDId')
  final String? kinopoiskHDId;
  @JsonKey(name: 'imdbId')
  final String? imdbId;
  @JsonKey(name: 'nameRu')
  final String? nameRu;
  @JsonKey(name: 'nameEn')
  final String? nameEn;
  @JsonKey(name: 'nameOriginal')
  final String? nameOriginal;
  @JsonKey(name: 'posterUrl')
  final String posterUrl;
  @JsonKey(name: 'posterUrlPreview')
  final String posterUrlPreview;
  @JsonKey(name: 'coverUrl')
  final String? coverUrl;
  @JsonKey(name: 'logoUrl')
  final String? logoUrl;
  @JsonKey(name: 'reviewsCount')
  final int reviewsCount;
  @JsonKey(name: 'ratingGoodReview')
  final double? ratingGoodReview;
  @JsonKey(name: 'ratingGoodReviewVoteCount')
  final int? ratingGoodReviewVoteCount;
  @JsonKey(name: 'ratingKinopoisk')
  final double? ratingKinopoisk;
  @JsonKey(name: 'ratingKinopoiskVoteCount')
  final int? ratingKinopoiskVoteCount;
  @JsonKey(name: 'ratingImdb')
  final double? ratingImdb;
  @JsonKey(name: 'ratingImdbVoteCount')
  final int? ratingImdbVoteCount;
  @JsonKey(name: 'ratingFilmCritics')
  final double? ratingFilmCritics;
  @JsonKey(name: 'ratingFilmCriticsVoteCount')
  final int? ratingFilmCriticsVoteCount;
  @JsonKey(name: 'ratingAwait')
  final double? ratingAwait;
  @JsonKey(name: 'ratingAwaitCount')
  final int? ratingAwaitCount;
  @JsonKey(name: 'ratingRfCritics')
  final double? ratingRfCritics;
  @JsonKey(name: 'ratingRfCriticsVoteCount')
  final int? ratingRfCriticsVoteCount;
  @JsonKey(name: 'webUrl')
  final String webUrl;
  @JsonKey(name: 'year')
  final int? year;
  @JsonKey(name: 'filmLength')
  final int? filmLength;
  @JsonKey(name: 'slogan')
  final String? slogan;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'shortDescription')
  final String? shortDescription;
  @JsonKey(name: 'editorAnnotation')
  final String? editorAnnotation;
  @JsonKey(name: 'isTicketsAvailable')
  final bool isTicketsAvailable;
  @JsonKey(name: 'productionStatus')
  final String? productionStatus;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'ratingMpaa')
  final String? ratingMpaa;
  @JsonKey(name: 'ratingAgeLimits')
  final String? ratingAgeLimits;
  @JsonKey(name: 'hasImax')
  final bool? hasImax;
  @JsonKey(name: 'has3D')
  final bool? has3D;
  @JsonKey(name: 'lastSync')
  final String? lastSync;
  @JsonKey(name: 'countries', fromJson: _countriesFromJson)
  final List<String> countries;
  @JsonKey(name: 'genres', fromJson: _genresFromJson)
  final List<String> genres;
  @JsonKey(name: 'startYear', )
  final int? startYear;
  @JsonKey(name: 'endYear')
  final int? endYear;
  @JsonKey(name: 'serial')
  final bool? serial;
  @JsonKey(name: 'shortFilm')
  final bool? shortFilm;
  @JsonKey(name: 'completed')
  final bool? completed;

  DetailDTO({
    required this.kinopoiskId,
    required this.kinopoiskHDId,
    required this.imdbId,
    required this.nameRu,
    this.nameEn,
    required this.nameOriginal,
    required this.posterUrl,
    required this.posterUrlPreview,
    this.coverUrl,
    this.logoUrl,
    required this.reviewsCount,
    required this.ratingGoodReview,
    required this.ratingGoodReviewVoteCount,
    required this.ratingKinopoisk,
    required this.ratingKinopoiskVoteCount,
    required this.ratingImdb,
    required this.ratingImdbVoteCount,
    required this.ratingFilmCritics,
    required this.ratingFilmCriticsVoteCount,
    required this.ratingAwait,
    required this.ratingAwaitCount,
    required this.ratingRfCritics,
    required this.ratingRfCriticsVoteCount,
    required this.webUrl,
    required this.year,
    required this.filmLength,
    this.slogan,
    this.description,
    this.shortDescription,
    this.editorAnnotation,
    required this.isTicketsAvailable,
    this.productionStatus,
    required this.type,
    required this.ratingMpaa,
    required this.ratingAgeLimits,
    required this.hasImax,
    required this.has3D,
    required this.lastSync,
    required this.countries,
    required this.genres,
    this.startYear,
    this.endYear,
    required this.serial,
    required this.shortFilm,
    required this.completed,
  });

  static List<String> _genresFromJson(List<dynamic> json) {
    return json.map((e) => e['genre'] as String).toList();
  }

  static List<String> _countriesFromJson(List<dynamic> json) {
    return json.map((e) => e['country'] as String).toList();
  }

  factory DetailDTO.fromJson(Map<String, dynamic> json) =>
      _$DetailDTOFromJson(json);
  Map<String, dynamic> toJson() => _$DetailDTOToJson(this);
}
