import 'package:tasti_restaurant_app/features/admin/transaction_history/domain/entities/transaction_history.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ITransactionHistoryRepo {
  Future<DataState<TransactionHistoryEntity>> fetchTransactionHistory(PaginationParms parms);
}
