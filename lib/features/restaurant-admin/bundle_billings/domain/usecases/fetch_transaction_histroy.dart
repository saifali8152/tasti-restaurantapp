import '/core/parms/parms.dart';
import '/features/restaurant-admin/bundle_billings/domain/entities/transaction_history.dart';
import '/features/restaurant-admin/bundle_billings/domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchTransactionHistroyUsecase extends UseCase<DataState<ReataurantTransactionHistoryEntity>, PaginationParms>{
  final IBundleBillingRepo repo;
  
  FetchTransactionHistroyUsecase(this.repo);

  @override
  Future<DataState<ReataurantTransactionHistoryEntity>> call(parms) {
    return repo.fetchTransactionHistory(parms);
  }
}