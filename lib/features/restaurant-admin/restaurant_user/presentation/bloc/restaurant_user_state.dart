import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';
import '/core/network/response.dart';

class RestaurantUserState extends Equatable {
  final ApiResponse<RestaurantUserEntity> addResponse;
  final ApiResponse<RestaurantUserEntity> updateResponse;
  final ApiResponse<List<RestaurantUserEntity>> fetchResponse;
  final ApiResponse<String> deleteResponse;

  const RestaurantUserState({
    required this.addResponse,
    required this.deleteResponse,
    required this.fetchResponse,
    required this.updateResponse,
  });

  RestaurantUserState copyWith({
    ApiResponse<RestaurantUserEntity>? addResponse,
    ApiResponse<RestaurantUserEntity>? updateResponse,
        ApiResponse<String>? deleteResponse,

    ApiResponse<List<RestaurantUserEntity>>? fetchResponse,
  }) {
    return RestaurantUserState(
      deleteResponse: deleteResponse ?? ApiResponse.initial(),
      addResponse: addResponse ?? ApiResponse.initial(),
      updateResponse: updateResponse ?? ApiResponse.initial(),
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [addResponse, fetchResponse, updateResponse, deleteResponse];
}
