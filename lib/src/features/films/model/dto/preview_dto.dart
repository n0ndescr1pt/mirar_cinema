import 'package:json_annotation/json_annotation.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';

part 'preview_dto.g.dart';

@JsonSerializable()
class PreviewDTO {
  @JsonKey(name: 'kinopoiskId')
  final int kinopoiskId;

  @JsonKey(name: 'nameRu')
  final String? nameRu;

  @JsonKey(name: 'nameEn')
  final String? nameEn;

  @JsonKey(name: 'nameOriginal')
  final String? nameOriginal;

  @JsonKey(name: 'countries', fromJson: _countriesFromJson)
  final List<String> countries;

  @JsonKey(name: 'genres', fromJson: _genresFromJson)
  final List<String> genres;

  @JsonKey(name: 'ratingKinopoisk')
  final double? ratingKinopoisk;

  @JsonKey(name: 'ratingImdb')
  final double? ratingImdb;

  @JsonKey(name: 'year')
  final int? year;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'posterUrl')
  final String? posterUrl;

  @JsonKey(name: 'posterUrlPreview')
  final String? posterUrlPreview;

  @JsonKey(name: 'premiereRu')
  final String? premiereRu;

  PreviewDTO({
    required this.kinopoiskId,
    required this.premiereRu,
    required this.nameRu,
    this.nameEn,
    this.nameOriginal,
    required this.countries,
    required this.genres,
    required this.ratingKinopoisk,
    required this.ratingImdb,
    required this.year,
    required this.type,
    required this.posterUrl,
    required this.posterUrlPreview,
  });

  static List<String> _countriesFromJson(List<dynamic> json) =>
      json.map((e) => e['country'] as String).toList();

  static List<String> _genresFromJson(List<dynamic> json) =>
      json.map((e) => e['genre'] as String).toList();

  factory PreviewDTO.fromJson(Map<String, dynamic> json) =>
      _$PreviewDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewDTOToJson(this);
}

extension PreviewDTOMapper on PreviewDTO {
  PreviewModel toModel() {
    return PreviewModel(
      kinopoiskId: kinopoiskId,
      nameRu: nameRu,
      nameEn: nameEn,
      nameOriginal: nameOriginal,
      countries: countries,
      genres: genres,
      ratingKinopoisk: ratingKinopoisk,
      ratingImdb: ratingImdb,
      year: year,
      type: type,
      posterUrl: posterUrl,
      posterUrlPreview: posterUrlPreview,
      premiereRu: premiereRu,
    );
  }
}
