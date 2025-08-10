import 'package:tasti_restaurant_app/features/reviews/data/models/review.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IReviewsRemoteApi {
  Future<ReviewModel> fetchReviews(String id);
  Future<String> verifyReview(VerifyUnverifyReviewParms parms);
  Future<String> unVerifyReview(VerifyUnverifyReviewParms parms);
}

class ReviewsRemoteApiImpl extends IReviewsRemoteApi {
  final IApiService networkApiService;
  ReviewsRemoteApiImpl(this.networkApiService);

  @override
  Future<ReviewModel> fetchReviews(String id) async {
    Map<String, String> data = {"id": id};

    var response = await networkApiService.get(
      AppUrls.fetchReviews,
      queryParams: data,
    );
    final ReviewModel reviews = ReviewModel.fromJson(response['data']);
        return reviews;
  }

  @override
  Future<String> unVerifyReview(VerifyUnverifyReviewParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "review_id": parms.reviewId,
    };

    var response = await networkApiService.post(AppUrls.unverifyReview, data);
    return response['message'];
  }

  @override
  Future<String> verifyReview(VerifyUnverifyReviewParms parms) async {
    Map<String, String> data = {
      "id": parms.id.toString(),
      "review_id": parms.reviewId,
    };

    var response = await networkApiService.post(AppUrls.verifyReview, data);
    return response['message'];
  }
}
