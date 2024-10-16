import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'films_event.dart';
part 'films_state.dart';
part 'films_bloc.freezed.dart';

class FilmsBloc extends Bloc<FilmsEvent, FilmsState> {
  final Talker _talker;
  FilmsBloc({required Talker talker})
      : _talker = talker,
        super(const FilmsState.initial()) {
    on<FilmsEvent>(_onLoad);
  }

  _onLoad(FilmsEvent event, Emitter<FilmsState> emit) async {
    try {} catch (e) {
      _talker.error("SkillsBloc _onLoad", e);
    }
  }
}
