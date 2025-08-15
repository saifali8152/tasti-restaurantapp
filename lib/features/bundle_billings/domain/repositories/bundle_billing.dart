import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class IBundleBillingRepo {
  Future<DataState<List<SMSEntity>>> fetchSMS();
  Future<DataState<BundleEntity>> fetchBundles(PaginationParms parms);
  Future<DataState<ReataurantTransactionHistoryEntity>> fetchTransactionHistory(PaginationParms parms);

  Future<DataState<String>> deleteSeatingArea(String id);
  Future<DataState<String>> addSeatingAreas(SeatingAreaParms parms);
  Future<DataState<String>> updateSeatingAreas(SeatingAreaParms parms);
}
