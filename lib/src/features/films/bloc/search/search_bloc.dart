import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/data/film_repository.dart';
import 'package:mirar/src/features/films/model/search_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IFilmRepository _filmRepository;
  final Talker _talker;
  SearchBloc({required IFilmRepository filmRepository, required Talker talker})
      : _filmRepository = filmRepository,
        _talker = talker,
        super(const SearchState.initial()) {
    on<_SearchEvent>(_onSearch);
  }

  _onSearch(_SearchEvent event, Emitter<SearchState> emit) async {
    emit(const SearchState.loading());
    try {
      final films = await _filmRepository.searchFilms(event.title);
      emit(SearchState.loaded(films: films));
    } catch (e, st) {
      _talker.error(e, st);
    }
  }
}
