import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/add_update_waiter.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/fetch_reservations.dart';
import '/core/network/response.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final FetchReservationsUsecase _fetchUsecase;
  final AddUpdateWaiterUsecase _addUpdateWaiterUsecase;

  ReservationBloc(
    this._fetchUsecase,
    this._addUpdateWaiterUsecase,
  ) : super(ReservationState(
          fetchResponse: ApiResponse.initial(),
          addUpdateWaiter: ApiResponse.initial(),
        )) {
    on<FetchReservationEvent>(_onFetchReservationEvent);
    on<AddUpdateWaiter>(_onAddUpdateWaiter);
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
        emit(state.copyWith(addUpdateWaiter: ApiResponse.completed(result.data)));
        add(FetchReservationEvent(FetchReservationParms(id: event.parms.restaurantId.toString()))); 
        break;
      case DataFailure():
        emit(state.copyWith(addUpdateWaiter: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(addUpdateWaiter: ApiResponse.initial()));
    }
  }
}
