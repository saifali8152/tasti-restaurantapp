import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/skaleton/user_cubit/skaleton_cubit.dart';
import '/features/auth/domain/entities/user.dart';
import '/features/auth/domain/usecases/login.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase)
      : super(LoginState(loginResponse: ApiResponse.initial())) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    // emit(state.copyWith(loginResponse: ApiResponse.loading()));

    final parms = LoginParms(email: state.email, password: state.password);
    final result = await _loginUseCase(parms);

    switch (result) {
      case DataSuccess<UserEntity>():
        final SessionController sC = sl();
        await sC.saveUserSession(result.data);
        await sC.loadSession();
        sl<UserCubit>().setUser(result.data);
        emit(state.copyWith(loginResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(loginResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(loginResponse: ApiResponse.initial()));
    }
  }
}
