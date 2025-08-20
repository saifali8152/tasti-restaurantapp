import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/enum/account_type.dart';
import '/dependency_injection.dart';
import '/features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '../../../domain/usecases/delete_account.dart';
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
      final userType = sl<UserCubitState>().user!.type == 'admin' ? AccountType.admin : AccountType.restaurant;
      final result = await _deleteAccountUsecase.call(userType);

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
