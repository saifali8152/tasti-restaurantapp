import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/restaurant-admin/dashboard/domain/entities/dashboard.dart';
import '/features/restaurant-admin/dashboard/domain/usecases/fetch_dashboard.dart';
import '/core/network/response.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc
    extends Bloc<DashboardEvent, DashboardState> {
  final FetchDashboardUseCase _useCase;

  DashboardBloc(this._useCase) : super(DashboardInitial()) {
    on<FetchDashboard>(_onFetchDashboard);
  }

  Future<void> _onFetchDashboard(
      FetchDashboard event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());

    try {
      final result = await _useCase.call(null);
      if (result is DataSuccess<DashboardEntity>) {
        emit(DashboardSuccess(result.data));
      } else if (result is DataFailure<DashboardEntity>) {
        emit(DashboardError(result.error.toString()));
      }
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
