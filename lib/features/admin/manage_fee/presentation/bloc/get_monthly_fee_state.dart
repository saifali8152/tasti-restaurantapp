import '/core/network/response.dart';
import '/features/admin/manage_fee/domain/entities/monthly_fee.dart';

class MonthlyFeeState {
  final ApiResponse<MonthlyFeeEntity> fetchResponse;
  final ApiResponse<String> updateResponse;
  
  MonthlyFeeState({
    required this.fetchResponse,
    required this.updateResponse,
  });

  MonthlyFeeState copyWith({
    ApiResponse<MonthlyFeeEntity>? fetchResponse,
    ApiResponse<String>? updateResponse,
  }) {
    return MonthlyFeeState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      updateResponse: updateResponse ?? this.updateResponse,
    );
  }
}