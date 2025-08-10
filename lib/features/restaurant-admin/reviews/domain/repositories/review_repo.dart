import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IReviewsRepo {
  Future<DataState<ReviewEntity>> fetchReviews(String id);
  Future<DataState<String>> verifyReview(VerifyUnverifyReviewParms parms);
  Future<DataState<String>> unVerifyReview(VerifyUnverifyReviewParms parms);
}
