import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/admin/admin_user/domain/entities/restaurant_user.dart';
import '/core/network/response.dart';

class AdminUserState extends Equatable {
  final ApiResponse<AdminUserEntity> addResponse;
  final ApiResponse<AdminUserEntity> updateResponse;
  final ApiResponse<List<AdminUserEntity>> fetchResponse;
  final ApiResponse<String> deleteResponse;

  const AdminUserState({
    required this.addResponse,
    required this.deleteResponse,
    required this.fetchResponse,
    required this.updateResponse,
  });

  AdminUserState copyWith({
    ApiResponse<AdminUserEntity>? addResponse,
    ApiResponse<AdminUserEntity>? updateResponse,
        ApiResponse<String>? deleteResponse,

    ApiResponse<List<AdminUserEntity>>? fetchResponse,
  }) {
    return AdminUserState(
      deleteResponse: deleteResponse ?? ApiResponse.initial(),
      addResponse: addResponse ?? this.addResponse,
      updateResponse: updateResponse ?? this.updateResponse,
      fetchResponse: fetchResponse ?? this.fetchResponse,
    );
  }

  @override
  List<Object?> get props => [addResponse, fetchResponse, updateResponse, deleteResponse];
}
