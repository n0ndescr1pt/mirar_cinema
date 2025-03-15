part of 'watch_history_bloc.dart';

@freezed
class WatchHistoryEvent with _$WatchHistoryEvent {
  const factory WatchHistoryEvent.started() = _Started;
  const factory WatchHistoryEvent.addWatchHistory(
      {required DetailModel film,
      required String userId}) = _AddWatchHistoryEvent;
  const factory WatchHistoryEvent.getWatchHistory({required String userId}) =
      _GetWatchHistory;
}
