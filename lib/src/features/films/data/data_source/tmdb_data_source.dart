import 'package:injectable/injectable.dart';
import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/model/dto/detail_dto.dart';
import 'package:mirar/src/features/films/model/dto/preview_dto.dart';

abstract interface class IKinopoiskDataSource {
  Future<List<PreviewDTO>> fetchPopular();
  Future<List<PreviewDTO>> fetchTopRated();
  Future<List<PreviewDTO>> fetchUpcoming();
  Future<DetailDTO> fetchDetailFilm(String id);
  Future<List<PreviewDTO>> searchFilms(String title);
}

@Injectable(as: IKinopoiskDataSource, env: [Environment.prod])
class KinopoiskDataSource implements IKinopoiskDataSource {
  final ApiProvider _apiProvider;
  const KinopoiskDataSource({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<List<PreviewDTO>> fetchPopular() async {
    try {
      final response = await _apiProvider.apiCall(
        "/movie/popular?api_key=0a913bff75919031103208bb1b2963ef",
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
        "/movie/top_rated?api_key=0a913bff75919031103208bb1b2963ef",
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
        "/movie/upcoming?api_key=0a913bff75919031103208bb1b2963ef",
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
        "/api/v2.2/films/$id",
        requestType: RequestType.get,
      );
      final result = response.data as Map<String, dynamic>;
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
        "/api/v2.1/films/search-by-keyword",
        queryParameters: {"keyword": title},
        requestType: RequestType.get,
      );
      if (response.data == null) {
        return [];
      }
      final result = response.data['films'] as List<dynamic>;
      final list = result.map((e) => PreviewDTO.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
}
