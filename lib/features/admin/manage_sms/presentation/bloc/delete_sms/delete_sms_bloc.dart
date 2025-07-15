import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/admin/manage_sms/domain/usecases/delete_sms_bundle.dart';
import '/core/network/response.dart';
import 'delete_sms_event.dart';
import 'delete_sms_state.dart';

class AdminDeleteSmsBloc extends Bloc<AdminDeleteSmsEvent, AdminDeleteSmsState> {
  final DeleteSMSBundleUsecase _usecase;

  AdminDeleteSmsBloc(this._usecase) : super(AdminDeleteSmsInitial()) {
    on<AdminDeleteSmsRequested>(_onAdminDeleteSmsRequested);
  }

  Future<void> _onAdminDeleteSmsRequested(
    AdminDeleteSmsRequested event,
    Emitter<AdminDeleteSmsState> emit,
  ) async {
    emit(AdminDeleteSmsLoading());

    try {
      final result = await _usecase.call(event.id);
      if (result is DataSuccess) {
        emit(AdminDeleteSmsSuccess());
      } else if (result is DataFailure<String>) {
        emit(AdminDeleteSmsError(result.error.toString()));
      }
    } catch (e) {
      emit(AdminDeleteSmsError(e.toString()));
    }
  }
}
