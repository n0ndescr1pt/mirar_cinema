import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/review/model/dto/watch_history_dto.dart';

abstract interface class IWatchHistoryDataSource {
  Future<void> addWatchHistory(DetailModel film, String userId);
  Future<List<WatchHistoryDTO>> getWatchHistory(String userId);
}

class WatchHistoryDataSource implements IWatchHistoryDataSource {
  final ApiProvider _apiProvider;
  WatchHistoryDataSource({required ApiProvider apiProvider})
      : _apiProvider = apiProvider;
  @override
  Future<void> addWatchHistory(DetailModel film, String userId) async {
    try {
      await _apiProvider.apiCall("/functions/addWatchHistory",
          requestType: RequestType.post, body: film.toWatchHistory(userId));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<WatchHistoryDTO>> getWatchHistory(String userId) async {
    try {
      final result = await _apiProvider.apiCall("/functions/getWatchHistory",
          requestType: RequestType.post, body: {"userId": userId});
      final data = result.data['result'] as List<dynamic>;
      if (data == []) {
        return [];
      }
      return data.map((e) => WatchHistoryDTO.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
