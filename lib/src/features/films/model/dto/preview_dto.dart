import 'package:json_annotation/json_annotation.dart';

part 'preview_dto.g.dart';

@JsonSerializable()
class PreviewDTO {
  @JsonKey(name: 'filmId')
  final int filmId;

  @JsonKey(name: 'nameRu')
  final String nameRu;

  @JsonKey(name: 'nameEn')
  final String? nameEn;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'year')
  final String year;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'filmLength')
  final String? filmLength;

  @JsonKey(name: 'countries', fromJson: _countriesFromJson)
  final List<String> countries;

  @JsonKey(name: 'genres', fromJson: _genresFromJson)
  final List<String> genres;

  @JsonKey(name: 'rating')
  final String rating;

  @JsonKey(name: 'ratingVoteCount')
  final int ratingVoteCount;

  @JsonKey(name: 'posterUrl')
  final String posterUrl;

  @JsonKey(name: 'posterUrlPreview')
  final String posterUrlPreview;

  PreviewDTO({
    required this.filmId,
    required this.nameRu,
    this.nameEn,
    required this.type,
    required this.year,
    this.description,
    this.filmLength,
    required this.countries,
    required this.genres,
    required this.rating,
    required this.ratingVoteCount,
    required this.posterUrl,
    required this.posterUrlPreview,
  });

  static List<String> _genresFromJson(List<dynamic> json) {
    return json.map((e) => e['genre'] as String).toList();
  }

  static List<String> _countriesFromJson(List<dynamic> json) {
    return json.map((e) => e['country'] as String).toList();
  }

  factory PreviewDTO.fromJson(Map<String, dynamic> json) =>
      _$PreviewDTOFromJson(json);
  Map<String, dynamic> toJson() => _$PreviewDTOToJson(this);
}
