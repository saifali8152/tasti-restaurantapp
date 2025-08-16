import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/transaction_history.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/repositories/bundle_billing.dart';
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