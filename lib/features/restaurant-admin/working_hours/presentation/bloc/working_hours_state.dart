import 'package:equatable/equatable.dart';
import '/features/restaurant-admin/working_hours/data/models/working_hour.dart';
import '/core/network/response.dart';

class WorkingHoursState extends Equatable {
  final ApiResponse<WorkingHourModel> fetchResponse;
  final ApiResponse<String> addResponse;
  final ApiResponse<String> updateResponse;

  const WorkingHoursState({
    required this.fetchResponse,
    required this.addResponse,
    required this.updateResponse,
  });

  WorkingHoursState copyWith({
    ApiResponse<WorkingHourModel>? fetchResponse,
    ApiResponse<String>? addResponse,
    ApiResponse<String>? updateResponse,
  }) {
    return WorkingHoursState(
      fetchResponse: fetchResponse ?? this.fetchResponse,
      addResponse: addResponse ?? ApiResponse.initial(),
      updateResponse: updateResponse ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props => [fetchResponse, addResponse, updateResponse];
}
