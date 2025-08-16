import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/repositories/bundle_billing.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class FetchBundlesUsecase extends UseCase<DataState<BundleEntity>, PaginationParms>{
  final IBundleBillingRepo repo;
  
  FetchBundlesUsecase(this.repo);

  @override
  Future<DataState<BundleEntity>> call(parms) {
    return repo.fetchBundles(parms);
  }
}