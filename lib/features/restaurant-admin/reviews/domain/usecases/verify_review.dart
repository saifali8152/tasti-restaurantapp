import '/core/parms/parms.dart';
import '/features/restaurant-admin/reviews/domain/repositories/review_repo.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class VerifyReviewUsecase extends UseCase<DataState<String>, VerifyUnverifyReviewParms>{
  final IReviewsRepo repo;
  
  VerifyReviewUsecase(this.repo);

  @override
  Future<DataState<String>> call(parm) {
    return repo.verifyReview(parm);
  }
}