import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/model/dto/preview_dto.dart';

part 'preview_model.freezed.dart';

@freezed
class PreviewModel with _$PreviewModel {
  const factory PreviewModel({
    required bool adult,
    required String backdropPath,
    required List<int> genreIds,
    required int id,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String posterPath,
    required String releaseDate,
    required String title,
    required bool video,
    required double voteAverage,
    required int voteCount,
  }) = _PreviewModel;
}

extension PreviewDTOMapper on PreviewDTO {
  PreviewModel toModel() {
    return PreviewModel(
      adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
