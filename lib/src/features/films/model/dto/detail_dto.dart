import 'package:json_annotation/json_annotation.dart';

part 'detail_dto.g.dart';

@JsonSerializable()
class DetailDTO {
  final bool adult;
  @JsonKey(name: 'backdrop_path')
  final String backdropPath;
  @JsonKey(name: 'belongs_to_collection')
  final String? belongsToCollection;
  final int budget;
  final List<GenreDTO> genres;
  final String homepage;
  final int id;
  @JsonKey(name: 'imdb_id')
  final String imdbId;
  @JsonKey(name: 'origin_country')
  final List<String> originCountry;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  final double popularity;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyDTO> productionCompanies;
  @JsonKey(name: 'production_countries')
  final List<ProductionCountryDTO> productionCountries;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  final int revenue;
  final int runtime;
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageDTO> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;

  DetailDTO({
    required this.adult,
    required this.backdropPath,
    this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory DetailDTO.fromJson(Map<String, dynamic> json) =>
      _$DetailDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DetailDTOToJson(this);
}

@JsonSerializable()
class GenreDTO {
  final int id;
  final String name;

  GenreDTO({required this.id, required this.name});

  factory GenreDTO.fromJson(Map<String, dynamic> json) => _$GenreDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDTOToJson(this);
}

@JsonSerializable()
class ProductionCompanyDTO {
  final int id;
  @JsonKey(name: 'logo_path')
  final String logoPath;
  final String name;
  @JsonKey(name: 'origin_country')
  final String originCountry;

  ProductionCompanyDTO(
      {required this.id,
      required this.logoPath,
      required this.name,
      required this.originCountry});

  factory ProductionCompanyDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyDTOToJson(this);
}

@JsonSerializable()
class ProductionCountryDTO {
  @JsonKey(name: 'iso_3166_1')
  final String iso3166_1;
  final String name;

  ProductionCountryDTO({required this.iso3166_1, required this.name});

  factory ProductionCountryDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryDTOToJson(this);
}

@JsonSerializable()
class SpokenLanguageDTO {
  @JsonKey(name: 'english_name')
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso639_1;
  final String name;

  SpokenLanguageDTO(
      {required this.englishName, required this.iso639_1, required this.name});

  factory SpokenLanguageDTO.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageDTOToJson(this);
}
