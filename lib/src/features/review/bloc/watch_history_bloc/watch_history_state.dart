part of 'watch_history_bloc.dart';

@freezed
class WatchHistoryState with _$WatchHistoryState {
  const factory WatchHistoryState.initial() = _Initial;
  const factory WatchHistoryState.loaded({required List<WatchHistoryModel> watchHistory}) = _Loaded;
  const factory WatchHistoryState.loading() = _Loading;
}
