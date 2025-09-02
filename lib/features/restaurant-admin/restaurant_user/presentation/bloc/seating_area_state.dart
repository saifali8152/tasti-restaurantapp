import 'package:equatable/equatable.dart';
import '/core/network/response.dart';

class UserState extends Equatable {
  final ApiResponse<String> addResponse;

  const UserState({
    required this.addResponse,
  });

  UserState copyWith({
    ApiResponse<String>? addResponse,
  }) {
    return UserState(
      addResponse: addResponse ?? this.addResponse,
    );
  }

  @override
  List<Object?> get props => [addResponse];
}
