import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/review/data/data_source/review_data_source.dart';
import 'package:mirar/src/features/review/model/review_model.dart';

abstract interface class IReviewRepository {
  Future<void> addReview(
      {required String userId,
      required DetailModel film,
      required double review});
  Future<List<ReviewModel>> getReview({required String userId});
}

class ReviewRepository implements IReviewRepository {
  final IReviewDataSource _reviewDataSource;
  ReviewRepository({required IReviewDataSource reviewDataSource})
      : _reviewDataSource = reviewDataSource;
  @override
  Future<void> addReview(
      {required String userId,
      required double review,
      required DetailModel film}) async {
    try {
      await _reviewDataSource.addReview(
          userId: userId, film: film, review: review);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ReviewModel>> getReview({required String userId}) async {
    try {
      final dto = await _reviewDataSource.getReview(userId: userId);
      return dto.map((e) => e.toModel()).toList();
    } catch (e) {
      rethrow;
    }
  }
}
