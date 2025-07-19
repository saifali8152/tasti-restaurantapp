import 'package:tasti_restaurant_app/core/network/response.dart';
import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/monthly_fee.dart';

class MonthlyFeeState {
  final ApiResponse<MonthlyFeeEntity> fetchResponse;
  final ApiResponse<String> addResponse;
  
  MonthlyFeeState({
    required this.fetchResponse,
    required this.addResponse,
  });

  MonthlyFeeState copyWith({
    ApiResponse<MonthlyFeeEntity>? fetchResponse,
    ApiResponse<String>? addResponse,
  }) {
    return MonthlyFeeState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      addResponse: addResponse ?? this.addResponse,
    );
  }
}