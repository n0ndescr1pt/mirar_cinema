import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/common/server_api.dart';
import '../model/rating_model.dart';
import '../model/watched_model.dart';

class StatisticsDataSource {
  final ApiProvider _apiProvider;

  StatisticsDataSource({required ApiProvider apiProvider})
      : _apiProvider = apiProvider;

  Future<List<RatingModel>> getUserRatings(String userId) async {
    try {
      final result = await _apiProvider.apiCall('/functions/getUserRatings',
          requestType: RequestType.post, body: {"userId": userId});

      if (result.statusCode == 200) {
        print(result.data);
        final data = result.data["result"] as List<dynamic>;

        return data.map((json) => RatingModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch ratings: ${result}');
      }
    } catch (e) {
      throw Exception('Error fetching ratings: $e');
    }
  }

  Future<List<WatchedModel>> getWatchedMovies(String userId) async {
    try {
      final result = await _apiProvider.apiCall('/functions/getWatched',
          requestType: RequestType.post, body: {"userId": userId});

      if (result.statusCode == 200) {
        print(result.data);
        final data = result.data["result"] as List<dynamic>;
        return data.map((json) => WatchedModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch watched movies: ${result}');
      }
    } catch (e) {
      throw Exception('Error fetching watched movies: $e');
    }
  }
}
