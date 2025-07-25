import '/features/admin/transaction_history/data/models/transaction_history.dart';
import '/features/admin/transaction_history/domain/repositories/transaction_history_repo.dart';
import '/core/parms/parms.dart';
import '../data_sources/transaction_history_remote_source.dart';
import '/core/network/response.dart';

class TransactionHistoryRepoImpl extends ITransactionHistoryRepo {
  final ITransactionHistoryRemoteSourceApi dataSource;
  TransactionHistoryRepoImpl(this.dataSource);

  @override
  Future<DataState<TransactionHistoryModel>> fetchTransactionHistory(PaginationParms parms) async{
    try {
      final result = await dataSource.fetchTransactionHistory(parms);
      return DataSuccess(result);
    } catch (error) {
      return DataFailure(error.toString());
    }
  }
}
