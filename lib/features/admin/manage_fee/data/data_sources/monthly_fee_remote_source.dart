import '/features/admin/manage_fee/data/models/monthly_fee.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IMonthlyFeeRemoteSourceApi {
  Future<String> updateMonthlyFee(UpdateMonthlyFeeParms parms);
  Future<MonthlyFeeModel> fetchMonthlyFee();
}

class MonthlyFeeSourceRemoteApiImpl extends IMonthlyFeeRemoteSourceApi {
  final IApiService networkApiService;
  MonthlyFeeSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<String> updateMonthlyFee(UpdateMonthlyFeeParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "id": parms.id,
      "money": parms.money,
    };
    var response = await networkApiService.post(AppUrls.adminUpdateMonthlyFee, data);

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
