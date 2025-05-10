part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class IsRegisterEvent extends AuthEvent {
  final bool isRegister;

  IsRegisterEvent({
    required this.isRegister,
  });
}

class SelectedRoleEvent extends AuthEvent {
  final String selectedRole;

  SelectedRoleEvent({
    required this.selectedRole,
  });
}

class RoleSelectedEvent extends AuthEvent {
  final bool roleSelected;

  RoleSelectedEvent({
    required this.roleSelected,
  });
}
class UsernameEvent extends AuthEvent {
  final String username;

  UsernameEvent({
    required this.username,
  });
}

class EmailEvent extends AuthEvent {
  final String email;

  EmailEvent({
    required this.email,
  });
}

class PasswordEvent extends AuthEvent {
  final String password;

  PasswordEvent({
    required this.password,
  });
}

class KvkNumberEvent extends AuthEvent {
  final String kvkNumber;

  KvkNumberEvent({
    required this.kvkNumber,
  });
}

class TermsAndConditionsCheckedEvent extends AuthEvent {
  final bool termsAndConditionsChecked;

  TermsAndConditionsCheckedEvent({
    required this.termsAndConditionsChecked,
  });
}
class RegisterEvent extends AuthEvent {}

class LoginEvent extends AuthEvent {}
