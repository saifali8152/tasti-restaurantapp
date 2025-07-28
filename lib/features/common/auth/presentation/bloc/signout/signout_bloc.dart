import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/signout.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import 'signout_event.dart';
import 'signout_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final SignOutUseCase _signOutUseCase;

  SignOutBloc(this._signOutUseCase) : super(SignOutInitial()) {
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<SignOutState> emit,
  ) async {
    emit(SignOutLoading());

    try {
      final result = await _signOutUseCase.call(null);
      if (result is DataSuccess) {
        await SessionController().clearSession();
        emit(SignOutSuccess());
      } else if (result is DataFailure<String>) {
        emit(SignOutError(result.error.toString()));
      }
    } catch (e) {
      emit(SignOutError(e.toString()));
    }
  }
}
