import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'films_event.dart';
part 'films_state.dart';
part 'films_bloc.freezed.dart';

class FilmsBloc extends Bloc<FilmsEvent, FilmsState> {
  final Talker _talker;
  final IFilmRepository _filmRepository;

  List<PreviewModel> topRated = [];
  int topRatedPage = 1;
  List<PreviewModel> upcoming = [];
  List<PreviewModel> popular = [];
  int popularPage = 1;
  bool isLoading = false;
  FilmsBloc({required Talker talker, required IFilmRepository filmRepository})
      : _talker = talker,
        _filmRepository = filmRepository,
        super(const FilmsState.initial()) {
    on<_LoadTopRatedEvent>(
      _onLoadTopRated,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<_LoadUpcomingEvent>(
      _onLoadUpcoming,
    );
    on<_LoadPopularEvent>(
      _onLoadPopular,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  _onLoadTopRated(_LoadTopRatedEvent event, Emitter<FilmsState> emit) async {
    isLoading = true;
    if (!(popularPage > 1)) {
      emit(const FilmsState.loading());
    }
    try {
      final newTopRated = await _filmRepository.fetchTopRated(topRatedPage);
      topRatedPage++;
      topRated = [...topRated, ...newTopRated];
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: upcoming, popular: popular));
      isLoading = false;
    } catch (e) {
      _talker.error(e);
      emit(FilmsState.error(error: e.toString()));
    }
  }

  _onLoadPopular(_LoadPopularEvent event, Emitter<FilmsState> emit) async {
    isLoading = true;
    if (!(popularPage > 1)) {
      emit(const FilmsState.loading());
    }
    try {
      final newPopular = await _filmRepository.fetchPopular(popularPage);
      popularPage++;
      popular = [...popular, ...newPopular];
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: upcoming, popular: popular));
      isLoading = false;
    } catch (e) {
      _talker.error(e);
      emit(FilmsState.error(error: e.toString()));
    }
  }

  _onLoadUpcoming(_LoadUpcomingEvent event, Emitter<FilmsState> emit) async {
    emit(const FilmsState.loading());
    try {
      final newUpcoming = await _filmRepository.fetchUpcoming();
      upcoming = [...upcoming, ...newUpcoming];
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: upcoming, popular: popular));
    } catch (e, st) {
      _talker.error(e, st);
    }
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
