import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/review/data/review_repository.dart';
import 'package:mirar/src/features/review/model/review_model.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'review_event.dart';
part 'review_state.dart';
part 'review_bloc.freezed.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final IReviewRepository _reviewRepository;
  final Talker _talker;
  ReviewBloc({
    required IReviewRepository reviewRepository,
    required Talker talker,
  })  : _reviewRepository = reviewRepository,
        _talker = talker,
        super(const _Initial()) {
    on<_AddReviewMovie>(_addReviewMovie);
    on<_GetReviewMovie>(_getReviewMovies);
  }
  _addReviewMovie(_AddReviewMovie event, Emitter<ReviewState> emit) async {
    try {
      print(event.userId);
      print(event.film);
      print(event.review);
      await _reviewRepository.addReview(
          userId: event.userId, film: event.film, review: event.review);
    } catch (e, st) {
      _talker.error(e, st);
    }
  }

  _getReviewMovies(_GetReviewMovie event, Emitter<ReviewState> emit) async {
    emit(const ReviewState.loading());
    try {
      final result = await _reviewRepository.getReview(userId: event.userId);
      emit(ReviewState.loaded(reviews: result));
    } catch (e, st) {
      _talker.error(e, st);
    }
  }
}
