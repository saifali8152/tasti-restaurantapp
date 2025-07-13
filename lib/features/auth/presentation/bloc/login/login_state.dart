import 'package:equatable/equatable.dart';
import '/features/auth/domain/entities/user.dart';
import '/core/network/response.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final ApiResponse<UserEntity> loginResponse;

  const LoginState({
    this.email = '',
    this.password = '',
    required this.loginResponse,
  });

  LoginState copyWith({
    String? email,
    String? password,
    ApiResponse<UserEntity>? loginResponse,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginResponse: loginResponse ?? this.loginResponse,
    );
  }

  @override
  List<Object?> get props => [email, password, loginResponse];
}