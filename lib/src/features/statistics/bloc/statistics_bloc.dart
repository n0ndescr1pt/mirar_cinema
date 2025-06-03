import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../data/statistics_data_source.dart';
import '../model/rating_model.dart';
import '../model/watched_model.dart';

// Events
abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object> get props => [];
}

class LoadStatistics extends StatisticsEvent {
  final String userId;

  const LoadStatistics({required this.userId});

  @override
  List<Object> get props => [userId];
}

// States
abstract class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final List<RatingModel> ratings;
  final List<WatchedModel> watchedMovies;
  final Map<String, int> genreStatistics;

  const StatisticsLoaded({
    required this.ratings,
    required this.watchedMovies,
    required this.genreStatistics,
  });

  @override
  List<Object> get props => [ratings, watchedMovies, genreStatistics];
}

class StatisticsError extends StatisticsState {
  final String message;

  const StatisticsError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final StatisticsDataSource _dataSource;
  final Talker _talker;

  StatisticsBloc({
    required StatisticsDataSource dataSource,
    required Talker talker,
  })  : _dataSource = dataSource,
        _talker = talker,
        super(StatisticsInitial()) {
    on<LoadStatistics>(_onLoadStatistics);
  }

  Future<void> _onLoadStatistics(
    LoadStatistics event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(StatisticsLoading());
    try {
      final ratings = await _dataSource.getUserRatings(event.userId);
      final watchedMovies = await _dataSource.getWatchedMovies(event.userId);

      // Calculate genre statistics
      final genreStats = <String, int>{};
      for (final movie in watchedMovies) {
        genreStats[movie.genre.first] = (genreStats[movie.genre] ?? 0) + 1;
      }

      emit(StatisticsLoaded(
        ratings: ratings,
        watchedMovies: watchedMovies,
        genreStatistics: genreStats,
      ));
    } catch (e) {
      _talker.error('Error loading statistics: $e');
      emit(StatisticsError(e.toString()));
    }
  }
}
