import 'package:mirar/src/features/review/data/data_source/wat%D1%81h_history_data_source.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/review/model/watch_history_model.dart';

abstract interface class IWatchHistoryRepository {
  Future<void> addWatchHistory(DetailModel film, String userId);
  Future<List<WatchHistoryModel>> getWatchHistory(String userId);
}

class WatchHistoryRepository implements IWatchHistoryRepository {
  final IWatchHistoryDataSource _watchHistoryDataSource;
  WatchHistoryRepository({
    required IWatchHistoryDataSource watchHistoryDataSource,
  })  : 
        _watchHistoryDataSource = watchHistoryDataSource;


  @override
  Future<void> addWatchHistory(DetailModel film, String userId) async {
    await _watchHistoryDataSource.addWatchHistory(film, userId);
  }

  @override
  Future<List<WatchHistoryModel>> getWatchHistory(String userId) async {
    try {
      final dto = await _watchHistoryDataSource.getWatchHistory(userId);
      return dto.map((e) => e.toModel()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
