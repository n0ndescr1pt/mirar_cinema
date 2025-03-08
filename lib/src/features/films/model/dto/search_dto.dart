import 'package:json_annotation/json_annotation.dart';
import 'package:mirar/src/features/films/model/search_model.dart';

part 'search_dto.g.dart';

@JsonSerializable()
class SearchDTO {
  @JsonKey(name: 'filmId')
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

  @JsonKey(name: 'rating')
  final String? rating;

  @JsonKey(name: 'year')
  final String? year;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'posterUrl')
  final String? posterUrl;

  @JsonKey(name: 'posterUrlPreview')
  final String? posterUrlPreview;

  SearchDTO({
    required this.kinopoiskId,
    required this.nameRu,
    this.nameEn,
    this.nameOriginal,
    required this.countries,
    required this.genres,
    required this.rating,
    required this.year,
    required this.type,
    required this.posterUrl,
    required this.posterUrlPreview,
  });

  static List<String> _countriesFromJson(List<dynamic> json) =>
      json.map((e) => e['country'] as String).toList();

  static List<String> _genresFromJson(List<dynamic> json) =>
      json.map((e) => e['genre'] as String).toList();

  factory SearchDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDTOToJson(this);
}

extension SearchDTOMapper on SearchDTO {
  SearchModel toModel() {
    return SearchModel(
      kinopoiskId: kinopoiskId,
      nameRu: nameRu,
      nameEn: nameEn,
      nameOriginal: nameOriginal,
      countries: countries,
      genres: genres,
      rating: rating,
      year: year,
      type: type,
      posterUrl: posterUrl,
      posterUrlPreview: posterUrlPreview,
    );
  }
}
