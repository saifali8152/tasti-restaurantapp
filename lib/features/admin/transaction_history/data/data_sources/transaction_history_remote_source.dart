import 'package:tasti_restaurant_app/features/admin/transaction_history/data/models/transaction_history.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class ITransactionHistoryRemoteSourceApi {
  Future<TransactionHistoryModel> fetchTransactionHistory(PaginationParms parms);
}

class TransactionHistoryRemoteSourceImp extends ITransactionHistoryRemoteSourceApi {
  final IApiService networkApiService;
  TransactionHistoryRemoteSourceImp(this.networkApiService);

@override
  Future<TransactionHistoryModel> fetchTransactionHistory(PaginationParms parms) async {
    Map<String, String> data = {};

    data = {
      "page": parms.page.toString(),
      "limit": parms.limit.toString(),
    };
    final response =
        await networkApiService.get(AppUrls.fetchAdminTransactionHistory, queryParams: data);
    final Map<String, dynamic> adminReservation = response;

    final TransactionHistoryModel adminSmsList = TransactionHistoryModel.fromJson(adminReservation);

    return adminSmsList;
  }
}
