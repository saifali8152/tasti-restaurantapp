import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/admin/dashboard/domain/entities/admin_dashboard.dart';
import '/features/admin/dashboard/domain/usecases/fetch_admin_dashboard.dart';
import '/core/network/response.dart';
import 'admin_dashboard_event.dart';
import 'admin_dashboard_state.dart';

class AdminDashboardBloc
    extends Bloc<AdminDashboardEvent, AdminDashboardState> {
  final FetchAdminDashboardUseCase _useCase;

  AdminDashboardBloc(this._useCase) : super(AdminDashboardInitial()) {
    on<FetchAdminDashboard>(_onFetchAdminDashboard);
  }

  Future<void> _onFetchAdminDashboard(
      FetchAdminDashboard event, Emitter<AdminDashboardState> emit) async {
    emit(AdminDashboardLoading());

    try {
      final result = await _useCase.call(null);
      if (result is DataSuccess<AdminDashboardEntity>) {
        emit(AdminDashboardSuccess(result.data));
      } else if (result is DataFailure<AdminDashboardEntity>) {
        emit(AdminDashboardError(result.error.toString()));
      }
    } catch (e) {
      emit(AdminDashboardError(e.toString()));
    }
  }
}
