import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/review/data/watch_history_repository.dart';
import 'package:mirar/src/features/review/model/watch_history_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'watch_history_event.dart';
part 'watch_history_state.dart';
part 'watch_history_bloc.freezed.dart';

class WatchHistoryBloc extends Bloc<WatchHistoryEvent, WatchHistoryState> {
  final Talker _talker;
  final IWatchHistoryRepository _historyRepository;
  WatchHistoryBloc({
    required IWatchHistoryRepository historyRepository,
    required Talker talker,
  })  : _historyRepository = historyRepository,
        _talker = talker,
        super(const _Initial()) {
    on<_AddWatchHistoryEvent>(_addWatchHistory);
    on<_GetWatchHistory>(_getWatchHistory);
  }
  _addWatchHistory(
      _AddWatchHistoryEvent event, Emitter<WatchHistoryState> emit) async {
    try {
      await _historyRepository.addWatchHistory(event.film, event.userId);
    } catch (e, st) {
      _talker.error(e, st);
    }
  }

  _getWatchHistory(
      _GetWatchHistory event, Emitter<WatchHistoryState> emit) async {
    emit(const WatchHistoryState.loading());
    try {
      final result = await _historyRepository.getWatchHistory(event.userId);
      emit(WatchHistoryState.loaded(watchHistory: result));
    } catch (e, st) {
      _talker.error(e, st);
    }
  }
}
