import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/entities/reservation.dart';
import 'package:tasti_restaurant_app/features/reservations/domain/usecases/fetch_reservations.dart';
import '/core/network/response.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc
    extends Bloc<ReservationEvent, ReservationState> {
  final FetchReservationsUsecase _fetchUsecase;

  ReservationBloc(
    this._fetchUsecase,
  ) : super(ReservationState(fetchResponse: ApiResponse.initial())) {
    on<FetchReservationEvent>(_onFetchReservationEvent);
  }

  Future<void> _onFetchReservationEvent(
      FetchReservationEvent event,
      Emitter<ReservationState> emit) async {
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
}
