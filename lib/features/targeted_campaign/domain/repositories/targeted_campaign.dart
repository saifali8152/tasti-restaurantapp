import 'package:tasti_restaurant_app/features/restaurant-admin/bundle_billings/domain/entities/init_payment.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';

abstract class ITargetedCampaignRepo {
  Future<DataState<String>> addTargetedCampaign(AddTargetedCampaignParms parms);
  Future<DataState<InitPaymentEntity>> initCampaignPayment(String tempId);
  Future<DataState<String>> verifyCampaignPayment(VerifyCampaignPaymentParms parms);
}
