import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/cuisines/domain/entities/cuisine.dart';
import '/core/network/response.dart';

class CuisineState extends Equatable {
  final ApiResponse<String> deleteCuisine;
  final ApiResponse<String> addCuisine;
  final ApiResponse<List<CuisineEntity>> fetchCuisine;

  const CuisineState({
    required this.deleteCuisine,
    required this.addCuisine,
    required this.fetchCuisine,
  });

  CuisineState copyWith({
    ApiResponse<String>? deleteCuisine,
    ApiResponse<String>? addCuisine,
    ApiResponse<List<CuisineEntity>>? fetchCuisine,
  }) {
    return CuisineState(
      deleteCuisine: deleteCuisine ?? ApiResponse.initial(),
      addCuisine: addCuisine ?? ApiResponse.initial(),
      fetchCuisine: fetchCuisine ?? this.fetchCuisine,
    );
  }

  @override
  List<Object?> get props => [fetchCuisine, addCuisine, deleteCuisine];
}
