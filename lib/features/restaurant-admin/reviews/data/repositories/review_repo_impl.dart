import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/data/models/review.dart';
import '../data_sources/review_repo.dart';
import '../../domain/repositories/review_repo.dart';
import '/core/network/response.dart';

class ReviewsRepoImpl extends IReviewsRepo {
  final IReviewsRemoteApi remote;
  ReviewsRepoImpl(this.remote);

  @override
  Future<DataState<ReviewModel>> fetchReviews(String id) async {
    try {
      final result = await remote.fetchReviews(id);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> unVerifyReview(
      VerifyUnverifyReviewParms parms) async {
    try {
      final result = await remote.unVerifyReview(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }

  @override
  Future<DataState<String>> verifyReview(
      VerifyUnverifyReviewParms parms) async {
    try {
      final result = await remote.verifyReview(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
