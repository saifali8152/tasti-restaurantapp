import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/auth/domain/usecases/delete_account.dart';
import '/core/network/response.dart';
import '/core/services/session_controller.dart';
import 'delete_account_event.dart';
import 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountUsecase _deleteAccountUsecase;

  DeleteAccountBloc(this._deleteAccountUsecase) : super(DeleteAccountInitial()) {
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
  }

  Future<void> _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoading());

    try {
      final result = await _deleteAccountUsecase.call(null);

      if (result is DataSuccess) {
        emit(DeleteAccountSuccess());
        await SessionController().clearSession();
      } else if (result is DataFailure<String>) {
        emit(DeleteAccountError(result.error.toString()));
      }
    } catch (e) {
      emit(DeleteAccountError(e.toString()));
    }
  }
}
