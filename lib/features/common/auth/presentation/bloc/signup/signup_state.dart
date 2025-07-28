import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';
import '/core/network/response.dart';

class SignupState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final ApiResponse<UserEntity> signupResponse;

  const SignupState({
    this.firstName = '',
    this.lastName = '',
    this.phoneNumber = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    required this.signupResponse,
  });

  SignupState copyWith({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? confirmPassword,
    ApiResponse<UserEntity>? signupResponse,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      signupResponse: signupResponse ?? ApiResponse.initial(),
    );
  }

  @override
  List<Object?> get props => [email, confirmPassword, password, signupResponse, firstName, lastName, phoneNumber];
}