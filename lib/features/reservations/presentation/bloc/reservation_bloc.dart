import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/add_update_waiter.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/cancel_reservations.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/fetch_reservations.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/update_reservations_status.dart';
import '/core/network/response.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final FetchReservationsUsecase _fetchUsecase;
  final AddUpdateWaiterUsecase _addUpdateWaiterUsecase;
  final CancelReservationsUsecase _cancelUsecase;
  final UpdateReservationsStatusUsecase _updateUsecase;

  ReservationBloc(
    this._fetchUsecase,
    this._addUpdateWaiterUsecase,
    this._cancelUsecase,
    this._updateUsecase,
  ) : super(ReservationState(
          fetchResponse: ApiResponse.initial(),
          addUpdateWaiter: ApiResponse.initial(),
          updateResponse: ApiResponse.initial(),
          cancelResponse: ApiResponse.initial(),
        )) {
    on<FetchReservationEvent>(_onFetchReservationEvent);
    on<AddUpdateWaiter>(_onAddUpdateWaiter);
    on<CancelReservation>(_onCancelReservation);
    on<UpdateReservationStatus>(_onUpdateReservationStatus);
  }

  Future<void> _onFetchReservationEvent(
      FetchReservationEvent event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.parms);

    switch (result) {
      case DataSuccess<ReservationEntity>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onAddUpdateWaiter(
      AddUpdateWaiter event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(addUpdateWaiter: ApiResponse.loading()));
    final result = await _addUpdateWaiterUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(
            addUpdateWaiter: ApiResponse.completed(result.data)));
        add(FetchReservationEvent(
            FetchReservationParms(id: event.parms.restaurantId.toString())));
        break;
      case DataFailure():
        emit(state.copyWith(addUpdateWaiter: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(addUpdateWaiter: ApiResponse.initial()));
    }
  }

  Future<void> _onCancelReservation(
      CancelReservation event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(cancelResponse: ApiResponse.loading()));
    final result = await _cancelUsecase(event.id);

    switch (result) {
      case DataSuccess<String>():
        final currentEntity = state.fetchResponse.data;

        if (currentEntity != null) {
          final updatedList = currentEntity.data.map((reservation) {
            if (reservation.id.toString() == event.id) {
              return reservation.copyWith(
                statusDisplay: "cancelled",
              );
            }
            return reservation;
          }).toList();

          final updatedEntity = ReservationEntity(
            data: updatedList,
            stats: currentEntity.stats,
            total: currentEntity.total,
          );

          emit(
            state.copyWith(
              cancelResponse: ApiResponse.completed(result.data),
              fetchResponse: ApiResponse.completed(updatedEntity),
            ),
          );
        } else {
          emit(state.copyWith(
              cancelResponse: ApiResponse.completed(result.data)));
        }
        break;

      case DataFailure():
        emit(state.copyWith(cancelResponse: ApiResponse.error(result.error)));
        break;

      default:
        emit(state.copyWith(cancelResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onUpdateReservationStatus(
      UpdateReservationStatus event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(cancelResponse: ApiResponse.loading()));
    final result = await _updateUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        final currentEntity = state.fetchResponse.data;

        if (currentEntity != null) {
          final updatedList = currentEntity.data.map((reservation) {
            if (reservation.id.toString() == event.parms.reservationId.toString()) {
              return reservation.copyWith(
                statusDisplay: event.parms.status == 'yes'? "arrived": "no_show",
              );
            }
            return reservation;
          }).toList();

          final updatedEntity = ReservationEntity(
            data: updatedList,
            stats: currentEntity.stats,
            total: currentEntity.total,
          );

          emit(
            state.copyWith(
              cancelResponse: ApiResponse.completed(result.data),
              fetchResponse: ApiResponse.completed(updatedEntity),
            ),
          );
        } else {
          emit(state.copyWith(
              cancelResponse: ApiResponse.completed(result.data)));
        }
        break;

      case DataFailure():
        emit(state.copyWith(cancelResponse: ApiResponse.error(result.error)));
        break;

      default:
        emit(state.copyWith(cancelResponse: ApiResponse.initial()));
    }
  }
}
