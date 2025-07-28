import 'package:tasti_restaurant_app/features/common/manage_fee/domain/entities/initialize_payment.dart';
import 'package:tasti_restaurant_app/features/common/auth/data/models/user.dart';
import '/core/network/response.dart';
import '../../domain/entities/monthly_fee.dart';

class MonthlyFeeState {
  final ApiResponse<MonthlyFeeEntity> fetchResponse;
  final ApiResponse<InitializePaymentEntity> initResponse;
  final ApiResponse<UserModel> verifyResponse;
  final ApiResponse<String> updateResponse;
  
  MonthlyFeeState({
    required this.fetchResponse,
    required this.initResponse,
    required this.verifyResponse,
    required this.updateResponse,
  });

  MonthlyFeeState copyWith({
    ApiResponse<MonthlyFeeEntity>? fetchResponse,
    ApiResponse<InitializePaymentEntity>? initResponse,
    ApiResponse<UserModel>? verifyResponse,
    ApiResponse<String>? updateResponse,
  }) {
    return MonthlyFeeState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      initResponse: initResponse ?? this.initResponse,
      updateResponse: updateResponse ?? this.updateResponse,
    );
  }
}