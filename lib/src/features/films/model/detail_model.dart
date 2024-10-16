import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/model/dto/detail_dto.dart';

part 'detail_model.freezed.dart';

@freezed
class DetailModel with _$DetailModel {
  const factory DetailModel({
    required bool adult,
    required String backdropPath,
    String? belongsToCollection,
    required int budget,
    required List<GenreModel> genres,
    required String homepage,
    required int id,
    required String imdbId,
    required List<String> originCountry,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String posterPath,
    required List<ProductionCompanyModel> productionCompanies,
    required List<ProductionCountryModel> productionCountries,
    required String releaseDate,
    required int revenue,
    required int runtime,
    required List<SpokenLanguageModel> spokenLanguages,
    required String status,
    required String tagline,
    required String title,
    required bool video,
    required double voteAverage,
    required int voteCount,
  }) = _DetailModel;
}

@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    required int id,
    required String name,
  }) = _GenreModel;
}

@freezed
class ProductionCompanyModel with _$ProductionCompanyModel {
  const factory ProductionCompanyModel({
    required int id,
    required String logoPath,
    required String name,
    required String originCountry,
  }) = _ProductionCompanyModel;
}

@freezed
class ProductionCountryModel with _$ProductionCountryModel {
  const factory ProductionCountryModel({
    required String iso3166_1,
    required String name,
  }) = _ProductionCountryModel;
}

@freezed
class SpokenLanguageModel with _$SpokenLanguageModel {
  const factory SpokenLanguageModel({
    required String englishName,
    required String iso639_1,
    required String name,
  }) = _SpokenLanguageModel;
}

extension DetailDTOMapper on DetailDTO {
  DetailModel toModel() {
    return DetailModel(
      adult: adult,
      backdropPath: backdropPath,
      belongsToCollection: belongsToCollection,
      budget: budget,
      genres: genres.map((e) => e.toModel()).toList(),
      homepage: homepage,
      id: id,
      imdbId: imdbId,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: productionCompanies.map((e) => e.toModel()).toList(),
      productionCountries: productionCountries.map((e) => e.toModel()).toList(),
      releaseDate: releaseDate,
      revenue: revenue,
      runtime: runtime,
      spokenLanguages: spokenLanguages.map((e) => e.toModel()).toList(),
      status: status,
      tagline: tagline,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}

extension GenreDTOMapper on GenreDTO {
  GenreModel toModel() {
    return GenreModel(
      id: id,
      name: name,
    );
  }
}

extension ProductionCompanyDTOMapper on ProductionCompanyDTO {
  ProductionCompanyModel toModel() {
    return ProductionCompanyModel(
      id: id,
      logoPath: logoPath,
      name: name,
      originCountry: originCountry,
    );
  }
}

extension ProductionCountryDTOMapper on ProductionCountryDTO {
  ProductionCountryModel toModel() {
    return ProductionCountryModel(
      iso3166_1: iso3166_1,
      name: name,
    );
  }
}

extension SpokenLanguageDTOMapper on SpokenLanguageDTO {
  SpokenLanguageModel toModel() {
    return SpokenLanguageModel(
      englishName: englishName,
      iso639_1: iso639_1,
      name: name,
    );
  }
}
