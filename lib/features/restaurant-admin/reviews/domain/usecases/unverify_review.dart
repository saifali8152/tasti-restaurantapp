import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reviews/domain/repositories/review_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class UnVerifyReviewUsecase extends UseCase<DataState<String>, VerifyUnverifyReviewParms>{
  final IReviewsRepo repo;
  
  UnVerifyReviewUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.unVerifyReview(parm);
  }
}