import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/targeted_campaign/domain/repositories/targeted_campaign.dart';
import '/core/network/response.dart';
import '/core/usecase/usecase.dart';

class InitCampaignPaymentUsecase extends UseCase<DataState<InitPaymentEntity>, String>{
  final ITargetedCampaignRepo repo;
  
  InitCampaignPaymentUsecase(this.repo);

  @override
  Future<DataState<InitPaymentEntity>> call(bundleId) {
    return repo.initCampaignPayment(bundleId);
  }
}