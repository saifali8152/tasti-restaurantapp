import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import '/features/admin/reservations_database/domain/entities/reservation.dart';
import '/features/admin/reservations_database/domain/usecases/fetch_admin_reservations.dart';
import '/core/network/response.dart';
import 'admin_reservation_event.dart';
import 'admin_reservation_state.dart';

class AdminReservationBloc
    extends Bloc<AdminReservationEvent, AdminReservationState> {
  final FetchAdminReservationsUseCase _useCase;

  AdminReservationBloc(this._useCase) : super(AdminReservationInitial()) {
    on<FetchInitialAdminReservation>(_onFetchInitial);
    on<FetchMoreAdminReservation>(_onFetchMore);
    on<SearchAdminReservation>(_onSearchAdminReservation);
  }

  Future<void> _onSearchAdminReservation(
      SearchAdminReservation event, Emitter<AdminReservationState> emit) async {
    if (event.search.length < 2) return;
    emit(AdminReservationLoading());

    try {
      final parms = PaginationParms(
        page: '1',
        search: event.search,
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<AdminReservationEntity>) {
        emit(AdminReservationLoaded(
          data: result.data.data,
          pagination: result.data.pagination,
        ));
      } else if (result is DataFailure<AdminReservationEntity>) {
        emit(AdminReservationError(result.error.toString()));
      }
    } catch (e) {
      emit(AdminReservationError(e.toString()));
    }
  }

  Future<void> _onFetchInitial(FetchInitialAdminReservation event,
      Emitter<AdminReservationState> emit) async {
    emit(AdminReservationLoading());

    try {
      final parms = PaginationParms(
        page: '1',
        search: '',
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<AdminReservationEntity>) {
        emit(AdminReservationLoaded(
          data: result.data.data,
          pagination: result.data.pagination,
        ));
      } else if (result is DataFailure<AdminReservationEntity>) {
        emit(AdminReservationError(result.error.toString()));
      }
    } catch (e) {
      emit(AdminReservationError(e.toString()));
    }
  }

  Future<void> _onFetchMore(FetchMoreAdminReservation event,
      Emitter<AdminReservationState> emit) async {
    final currentState = state;

    if (currentState is AdminReservationLoaded &&
        currentState.pagination.hasNext &&
        !currentState.isLoadingMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final nextPage = currentState.pagination.currentPage + 1;
        final parms = PaginationParms(
          page: nextPage.toString(),
          search: currentState.search,
        );
        final result = await _useCase.call(parms);

        if (result is DataSuccess<AdminReservationEntity>) {
          final newData = result.data;

          final updatedList = List<AdminReservationItem>.from(currentState.data)
            ..addAll(newData.data);

          emit(AdminReservationLoaded(
            data: updatedList,
            pagination: newData.pagination,
            isLoadingMore: false,
          ));
        } else if (result is DataFailure<AdminReservationEntity>) {
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    }
  }
}
