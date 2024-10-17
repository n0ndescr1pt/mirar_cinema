import 'package:injectable/injectable.dart';
import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/model/dto/detail_dto.dart';
import 'package:mirar/src/features/films/model/dto/preview_dto.dart';

abstract interface class ITMDBDataSource {
  Future<List<PreviewDTO>> fetchPopular();
  Future<List<PreviewDTO>> fetchTopRated();
  Future<List<PreviewDTO>> fetchUpcoming();
  Future<DetailDTO> fetchDetailFilm(String id);
  Future<List<PreviewDTO>> searchFilms(String title);
}

@Injectable(as: ITMDBDataSource, env: [Environment.prod])
class TMDBDataSource implements ITMDBDataSource {
  final ApiProvider _apiProvider;
  const TMDBDataSource({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<List<PreviewDTO>> fetchPopular() async {
    try {
      final response = await _apiProvider.apiCall(
        "/movie/popular",
        requestType: RequestType.get,
      );
      if (response.data == null) {
        return [];
      }
      final result = response.data['result'] as List<dynamic>;
      print(result);
      final list = result.map((e) => PreviewDTO.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewDTO>> fetchTopRated() async {
    try {
      final response = await _apiProvider.apiCall(
        "/movie/top_rated",
        requestType: RequestType.get,
      );
      if (response.data == null) {
        return [];
      }
      final result = response.data['result'] as List<dynamic>;
      print(result);
      final list = result.map((e) => PreviewDTO.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewDTO>> fetchUpcoming() async {
    try {
      final response = await _apiProvider.apiCall(
        "/movie/upcoming",
        requestType: RequestType.get,
      );
      if (response.data == null) {
        return [];
      }
      final result = response.data['result'] as List<dynamic>;
      print(result);
      final list = result.map((e) => PreviewDTO.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<DetailDTO> fetchDetailFilm(String id) async {
    try {
      final response = await _apiProvider.apiCall(
        "/movie/$id",
        requestType: RequestType.get,
      );
      final result = response.data['result'] as Map<String, dynamic>;
      final detail = DetailDTO.fromJson(result);
      return detail;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewDTO>> searchFilms(String title) async {
    try {
      final response = await _apiProvider.apiCall(
        "/search/movie",
        queryParameters: {"query": title},
        requestType: RequestType.get,
      );
      if (response.data == null) {
        return [];
      }
      final result = response.data['result'] as dynamic;
      final list = result.map((e) => PreviewDTO.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
