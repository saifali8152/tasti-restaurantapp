import 'package:tasti_restaurant_app/features/admin/transaction_history/domain/entities/transaction_history.dart';
import 'package:tasti_restaurant_app/features/admin/transaction_history/domain/repositories/transaction_history_repo.dart';
import '/core/network/response.dart';
import '/core/parms/parms.dart';
import '/core/usecase/usecase.dart';

class FetchAdminTransactionHistory
    extends UseCase<DataState<TransactionHistoryEntity>, PaginationParms> {
  final ITransactionHistoryRepo repo;

  FetchAdminTransactionHistory(this.repo);

  @override
  Future<DataState<TransactionHistoryEntity>> call(PaginationParms parms) {
    return repo.fetchTransactionHistory(parms);
  }
}
