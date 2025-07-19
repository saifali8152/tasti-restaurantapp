import 'package:tasti_restaurant_app/features/admin/manage_fee/data/models/monthly_fee.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IMonthlyFeeRemoteSourceApi {
  Future<String> addSMSBundle(AddSMSBundleParms parms);
  Future<String> manageSmsBundleDiscount(ManageSmsBundleDiscountParms parms);
  Future<MonthlyFeeModel> fetchMonthlyFee();
}

class MonthlyFeeSourceRemoteApiImpl extends IMonthlyFeeRemoteSourceApi {
  final IApiService networkApiService;
  MonthlyFeeSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> manageSmsBundleDiscount(
      ManageSmsBundleDiscountParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "id": parms.id,
      "discount": parms.discount,
      "percentage": parms.percentage
    };
    var response =
        await networkApiService.post(AppUrls.adminManageDiscount, data);

    return response['message'];
  }

  @override
  Future<String> addSMSBundle(AddSMSBundleParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "owner": parms.owner,
      "quantity": parms.quantity,
      "discount": parms.discount,
      "price": parms.price,
      "percentage": parms.percentage
    };
    var response = await networkApiService.post(AppUrls.adminAddSMS, data);

    return response['message'];
  }

  @override
  Future<MonthlyFeeModel> fetchMonthlyFee() async {
    final response = await networkApiService.get(AppUrls.adminFetchMonthlyFee);
    final Map<String, dynamic> jsonReponse = response['data'];

    final MonthlyFeeModel monthlyFee = MonthlyFeeModel.fromJson(jsonReponse);

    return monthlyFee;
  }
}
