import 'package:equatable/equatable.dart';
import '/features/common/auth/domain/entities/user.dart';
import '/core/network/response.dart';

class CreateNewRestaurantState extends Equatable {
  final ApiResponse<UserRestaurantEntity> createRestaurantResponse;
  final ApiResponse<UserRestaurantEntity> updateRestaurantResponse;

  const CreateNewRestaurantState({
    required this.createRestaurantResponse,
    required this.updateRestaurantResponse,
  });

  CreateNewRestaurantState copyWith({
    ApiResponse<UserRestaurantEntity>? createRestaurantResponse,
    ApiResponse<UserRestaurantEntity>? updateRestaurantResponse,
  }) {
    return CreateNewRestaurantState(
      createRestaurantResponse:
          createRestaurantResponse ?? ApiResponse.initial(),
      updateRestaurantResponse:
          updateRestaurantResponse ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props =>
      [createRestaurantResponse, updateRestaurantResponse];
}
