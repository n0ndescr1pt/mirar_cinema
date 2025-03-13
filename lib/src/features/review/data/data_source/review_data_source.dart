import 'package:mirar/src/common/dio/dio_api.dart';
import 'package:mirar/src/features/films/model/detail_model.dart';
import 'package:mirar/src/features/review/model/dto/review_dto.dart';

abstract interface class IReviewDataSource {
  Future<void> addReview(
      {required String userId,
      required DetailModel film,
      required double review});
  Future<List<ReviewDTO>> getReview({required String userId});
}

class ReviewDataSource implements IReviewDataSource {
  final ApiProvider _apiProvider;
  ReviewDataSource({required ApiProvider apiProvider})
      : _apiProvider = apiProvider;
  @override
  Future<void> addReview(
      {required String userId,
      required double review,
      required DetailModel film}) async {
    try {
      await _apiProvider.apiCall("/functions/addMovieReview",
          requestType: RequestType.post,
          body: film.toReviewEntry(userId, review));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ReviewDTO>> getReview({required String userId}) async {
    try {
      final result = await _apiProvider.apiCall("/functions/getMovieReview",
          requestType: RequestType.post, body: {"userId": userId});

      final data = result.data['result'] as List<dynamic>;
      if (data == []) {
        return [];
      }
      return data.map((e) => ReviewDTO.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
