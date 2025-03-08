import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:mirar/src/features/films/model/preview_model.dart';
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
  int upcomingPage = 1;
  List<PreviewModel> popular = [];
  int popularPage = 1;
  FilmsBloc({required Talker talker, required IFilmRepository filmRepository})
      : _talker = talker,
        _filmRepository = filmRepository,
        super(const FilmsState.initial()) {
    on<_LoadTopRatedEvent>(_onLoadTopRated);
    on<_LoadUpcomingEvent>(_onLoadUpcoming);
    on<_LoadPopularEvent>(_onLoadPopular);
  }

  _onLoadTopRated(_LoadTopRatedEvent event, Emitter<FilmsState> emit) async {
    emit(const FilmsState.loading());
    try {
      final newTopRated = await _filmRepository.fetchTopRated();
      topRatedPage++;
      topRated = [...topRated, ...newTopRated];
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: upcoming, popular: popular));
    } catch (e) {
      _talker.error(e);
      emit(FilmsState.error(error: e.toString()));
    }
  }

  _onLoadPopular(_LoadPopularEvent event, Emitter<FilmsState> emit) async {
    emit(const FilmsState.loading());
    try {
      print(1);
      final newPopular = await _filmRepository.fetchPopular();
      popular = [...popular, ...newPopular];
      emit(FilmsState.loaded(
          topRated: topRated, upcoming: upcoming, popular: popular));
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
