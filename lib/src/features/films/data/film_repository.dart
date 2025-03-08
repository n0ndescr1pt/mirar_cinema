import 'package:mirar/src/features/films/data/data_source/tmdb_data_source.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/films/model/dto/preview_dto.dart';
import 'package:mirar/src/features/films/model/dto/search_dto.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:mirar/src/features/films/model/search_model.dart';

abstract interface class IFilmRepository {
  Future<List<PreviewModel>> fetchPopular();
  Future<List<PreviewModel>> fetchTopRated();
  Future<List<PreviewModel>> fetchUpcoming();
  Future<DetailModel> fetchDetailFilm(String id);
  Future<List<SearchModel>> searchFilms(String title);
}

class FilmRepository implements IFilmRepository {
  final IKinopoiskDataSource _tmdbDataSource;
  FilmRepository({required IKinopoiskDataSource tmdbDataSource})
      : _tmdbDataSource = tmdbDataSource;

  @override
  Future<DetailModel> fetchDetailFilm(String id) async {
    try {
      final dto = await _tmdbDataSource.fetchDetailFilm(id);
      return dto.toModel();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewModel>> fetchPopular() async {
    try {
      final dto = await _tmdbDataSource.fetchPopular();
      return dto.map((e) => e.toModel()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewModel>> fetchTopRated() async {
    try {
      final dto = await _tmdbDataSource.fetchTopRated();
      return dto.map((e) => e.toModel()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewModel>> fetchUpcoming() async {
    try {
      final dto = await _tmdbDataSource.fetchUpcoming();
      return dto.map((e) => e.toModel()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SearchModel>> searchFilms(String title) async {
    try {
      final dto = await _tmdbDataSource.searchFilms(title);
      return dto.map((e) => e.toModel()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
