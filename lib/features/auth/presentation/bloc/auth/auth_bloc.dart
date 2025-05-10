import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/core/network/response.dart';
import 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(
    isRegister: true,
    selectedRole: '',
    roleSelected: false,
    username: '',
    email: '',
    password: '',
    kvkNumber: '',
    termsAndConditionsChecked: false,
    registerResponse: ApiResponse.initial(),
    loginResponse: ApiResponse.initial(),
  )) {
    on<IsRegisterEvent>(_onIsRegisterEvent);
    on<SelectedRoleEvent>(_onSelectedRoleEvent);
    on<RoleSelectedEvent>(_onRoleSelectedEvent);
    on<UsernameEvent>(_onUsernameEvent);
    on<EmailEvent>(_onEmailEvent);
    on<PasswordEvent>(_onPasswordEvent);
    on<KvkNumberEvent>(_onKvkNumberEvent);
    on<TermsAndConditionsCheckedEvent>(_onTermsAndConditionsCheckedEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LoginEvent>(_onLoginEvent);
  }

  void _onIsRegisterEvent(IsRegisterEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(isRegister: event.isRegister));
  }

  void _onSelectedRoleEvent(SelectedRoleEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(selectedRole: event.selectedRole));
  }

  void _onRoleSelectedEvent(RoleSelectedEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(roleSelected: event.roleSelected));
  }

  void _onUsernameEvent(UsernameEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _onEmailEvent(EmailEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordEvent(PasswordEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onKvkNumberEvent(KvkNumberEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(kvkNumber: event.kvkNumber));
  }

  void _onTermsAndConditionsCheckedEvent(TermsAndConditionsCheckedEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(termsAndConditionsChecked: event.termsAndConditionsChecked));
  }

  void _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(registerResponse: ApiResponse.loading()));
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(loginResponse: ApiResponse.loading()));
  }
}