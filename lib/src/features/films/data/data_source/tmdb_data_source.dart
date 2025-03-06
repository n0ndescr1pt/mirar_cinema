import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/model/dto/detail_dto.dart';
import 'package:mirar/src/features/films/model/dto/preview_dto.dart';
import 'package:mirar/src/features/films/utils/month_converter.dart';

abstract interface class IKinopoiskDataSource {
  Future<List<PreviewDTO>> fetchPopular();
  Future<List<PreviewDTO>> fetchTopRated();
  Future<List<PreviewDTO>> fetchUpcoming();
  Future<DetailDTO> fetchDetailFilm(String id);
  Future<List<PreviewDTO>> searchFilms(String title);
}

class KinopoiskDataSource implements IKinopoiskDataSource {
  final ApiProvider _apiProvider;
  const KinopoiskDataSource({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

  @override
  Future<List<PreviewDTO>> fetchPopular() async {
    try {
      final response = await _apiProvider.apiCall(
        "/api/v2.2/films/collections",
        requestType: RequestType.get,
        queryParameters: {
          "type": "TOP_250_MOVIES",
          "api_key": "0a913bff75919031103208bb1b2963ef"
        },
      );

      if (response.data['items'] == null) {
        return [];
      }

      final result = response.data['items'] as List<dynamic>;

      final list = result.map((e) => PreviewDTO.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PreviewDTO>> fetchTopRated() async {
    try {
      final response = await _apiProvider.apiCall("/api/v2.2/films",
          requestType: RequestType.get,
          queryParameters: {
            "api_key": "0a913bff75919031103208bb1b2963ef",
            "order": "RATING",
            "ratingFrom": 9.0,
            "type": "FILM"
          });
      if (response.data == null) {
        return [];
      }
      final result = response.data['items'] as List<dynamic>;
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
        "/api/v2.2/films/premieres",
        requestType: RequestType.get,
        queryParameters: {
          "api_key": "0a913bff75919031103208bb1b2963ef",
          "year": DateTime.now().year,
          "month": monthConverter(DateTime.now().month+2).toUpperCase(),
        },
      );
      if (response.data == null) {
        return [];
      }
      final result = response.data['items'] as List<dynamic>;
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
