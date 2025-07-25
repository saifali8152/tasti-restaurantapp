import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/admin/profile/domain/usecases/change_password.dart';
import '/core/network/response.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUsecase _changePasswordUsecase;

  ChangePasswordBloc(this._changePasswordUsecase)
      : super(ChangePasswordInitial()) {
    on<ChangePasswordRequested>(_onChangePasswordRequested);
  }

  Future<void> _onChangePasswordRequested(
    ChangePasswordRequested event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());

    try {
      final result = await _changePasswordUsecase.call(event.parms);

      if (result is DataSuccess) {
        emit(ChangePasswordSuccess());
      } else if (result is DataFailure<String>) {
        emit(ChangePasswordError(result.error.toString()));
      }
    } catch (e) {
      emit(ChangePasswordError(e.toString()));
    }
  }
}
