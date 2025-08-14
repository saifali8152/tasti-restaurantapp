import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/entities/seating_area.dart';
import '/core/network/response.dart';

class SeatingAreaState extends Equatable {
  final ApiResponse<String> deleteResponse;
  final ApiResponse<String> addResponse;
  final ApiResponse<String> updateResponse;
  final ApiResponse<List<SeatingAreaEntity>> fetchResponse;

  const SeatingAreaState({
    required this.deleteResponse,
    required this.addResponse,
    required this.updateResponse,
    required this.fetchResponse,
  });

  SeatingAreaState copyWith({
    ApiResponse<String>? deleteResponse,
    ApiResponse<String>? addResponse,
    ApiResponse<String>? updateResponse,
    ApiResponse<List<SeatingAreaEntity>>? fetchResponse,
  }) {
    return SeatingAreaState(
      deleteResponse: deleteResponse ?? ApiResponse.initial(),
      addResponse: addResponse ?? ApiResponse.initial(),
      updateResponse: updateResponse ?? ApiResponse.initial(),
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [fetchResponse, addResponse, updateResponse, deleteResponse];
}
