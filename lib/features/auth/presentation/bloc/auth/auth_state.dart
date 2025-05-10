import '/core/network/response.dart';

class AuthState {
  final ApiResponse registerResponse;
  final ApiResponse loginResponse;
  final bool isRegister;
  final String selectedRole;
  final bool roleSelected;
  final String username;
  final String email;
  final String password;
  final String kvkNumber;
  final bool termsAndConditionsChecked;

  const AuthState({
    required this.isRegister,
    required this.selectedRole,
    required this.roleSelected,
    required this.username,
    required this.email,
    required this.password,
    required this.kvkNumber,
    required this.registerResponse,
    required this.loginResponse,
    required this.termsAndConditionsChecked,
  });

  AuthState copyWith({
    bool? isRegister,
    String? selectedRole,
    bool? roleSelected,
    String? username,
    String? email,
    String? password,
    String? kvkNumber,
    bool? termsAndConditionsChecked,
    ApiResponse? registerResponse,
    ApiResponse? loginResponse,
  }) {  
    return AuthState(
      isRegister: isRegister ?? this.isRegister,
      selectedRole: selectedRole ?? this.selectedRole,
      roleSelected: roleSelected ?? this.roleSelected,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      kvkNumber: kvkNumber ?? this.kvkNumber,
      termsAndConditionsChecked: termsAndConditionsChecked ?? this.termsAndConditionsChecked,
      registerResponse: registerResponse ?? this.registerResponse,
      loginResponse: loginResponse ?? this.loginResponse,
    );
  }

}