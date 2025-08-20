import '/core/services/session_controller.dart';
import '/features/common/manage_fee/data/models/initialize_payment.dart';
import '/features/common/auth/data/models/user.dart';
import '../models/monthly_fee.dart';
import '/core/parms/parms.dart';
import '/core/network/api_services.dart';
import '/config/constants/urls.dart';

abstract class IMonthlyFeeRemoteSourceApi {
  Future<String> updateMonthlyFee(UpdateMonthlyFeeParms parms);
  Future<MonthlyFeeModel> fetchMonthlyFee();
  Future<UserModel> verifyPayment(String reference);
  Future<InitializePaymentModel> initializePayment(String amount);
}

class MonthlyFeeSourceRemoteApiImpl extends IMonthlyFeeRemoteSourceApi {
  final IApiService networkApiService;
  MonthlyFeeSourceRemoteApiImpl(this.networkApiService);

  @override
  Future<UserModel> verifyPayment(String reference) async {
    var response = await networkApiService.get(AppUrls.verifyPayment, queryParams: {"reference": reference});
    final Map<String, dynamic> jsonReponse = response['restaurant'];
    final String status = response['subscription_status'].toString();
    final UserModel user = UserModel.fromEntity(SessionController().user!);
    final UserRestaurantModel restaurant = UserRestaurantModel.fromJson(jsonReponse);

    final UserModel updatedUser = user.copyWith(restaurant: restaurant, subscriptionStatus:status);

    return updatedUser;
  }

  @override
  Future<String> updateMonthlyFee(UpdateMonthlyFeeParms parms) async {
    Map<String, dynamic> data = {};

    data = {
      "id": parms.id,
      "money": parms.money,
    };
    var response =
        await networkApiService.post(AppUrls.adminUpdateMonthlyFee, data);

    return response['message'];
  }

  @override
  Future<MonthlyFeeModel> fetchMonthlyFee() async {
    final response = await networkApiService.get(AppUrls.adminFetchMonthlyFee);
    final Map<String, dynamic> jsonReponse = response['data'];

    final MonthlyFeeModel monthlyFee = MonthlyFeeModel.fromJson(jsonReponse);

    return monthlyFee;
  }

  @override
  Future<InitializePaymentModel> initializePayment(String amount) async {
    Map<String, dynamic> data = {};

    data = {"amount": amount};

    final response =
        await networkApiService.post(AppUrls.initializePayment, data);
    final Map<String, dynamic> jsonReponse = response['data'];

    final InitializePaymentModel initPayment =
        InitializePaymentModel.fromJson(jsonReponse);

    return initPayment;
  }
}
