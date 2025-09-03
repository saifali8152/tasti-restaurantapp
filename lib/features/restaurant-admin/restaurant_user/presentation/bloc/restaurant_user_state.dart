import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';
import '/core/network/response.dart';

class RestaurantUserState extends Equatable {
  final ApiResponse<String> addResponse;
  final ApiResponse<List<RestaurantUserEntity>> fetchResponse;

  const RestaurantUserState({
    required this.addResponse,
    required this.fetchResponse,
  });

  RestaurantUserState copyWith({
    ApiResponse<String>? addResponse,
    ApiResponse<List<RestaurantUserEntity>>? fetchResponse,
  }) {
    return RestaurantUserState(
      addResponse: addResponse ?? this.addResponse,
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [addResponse, fetchResponse];
}
