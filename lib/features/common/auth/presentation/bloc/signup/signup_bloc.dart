import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/common/auth/domain/usecases/signup.dart';
import '../../../../skaleton/user_cubit/skaleton_cubit.dart';
import '../../../domain/entities/user.dart';
import '/core/services/session_controller.dart';
import '/dependency_injection.dart';
import '/core/parms/parms.dart';
import '/core/network/response.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final SignUpUseCase _usecase;

  SignupBloc(this._usecase)
      : super(SignupState(signupResponse: ApiResponse.initial())) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _onFirstNameChanged(FirstNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(firstName: event.firstname));
  }

  void _onLastNameChanged(LastNameChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(lastName: event.lastName));
  }

  void _onEmailChanged(EmailChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  Future<void> _onSignUpSubmitted(
      SignUpSubmitted event, Emitter<SignupState> emit) async {
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(
          signupResponse: ApiResponse.error("Passwords do not match")));
      return;
    }
    emit(state.copyWith(signupResponse: ApiResponse.loading()));

    final parms = SignupParms(
      firstName: state.firstName,
      lastName: state.lastName,
      phone: state.phoneNumber,
      email: state.email,
      password: state.password,
    );
    final result = await _usecase(parms);

    switch (result) {
      case DataSuccess<UserEntity>():
        final SessionController sC = sl();
        await sC.saveUserSession(result.data);
        await sC.loadSession();
        sl<UserCubit>().setUser(result.data);
        emit(
            state.copyWith(signupResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(signupResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(signupResponse: ApiResponse.initial()));
    }
  }
}
