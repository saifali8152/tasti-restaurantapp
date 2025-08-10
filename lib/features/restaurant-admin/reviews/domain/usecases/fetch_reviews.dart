import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/entities/reviews.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/repositories/review_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchReviewsUsecase extends UseCase<DataState<ReviewEntity>, String>{
  final IReviewsRepo repo;
  
  FetchReviewsUsecase(this.repo);

  @override
  Future<DataState<ReviewEntity>> call(parm) {
    return repo.fetchReviews(parm);
  }
}