import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_time_slots.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/usecases/make_reservations.dart';
import '/core/network/response.dart';
import 'make_reservation_event.dart';
import 'make_reservation_state.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/entities/restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/usecases/fetch_restaurant_seating_area.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/usecases/fetch_restaurant_tables.dart';
import 'package:tasti_restaurant_app/features/make_reservation/domain/usecases/fetch_restaurant_time_slots.dart';

class MakeReservationBloc
    extends Bloc<MakeReservationEvent, MakeReservationState> {
  final FetchRestaurantSeatingAreaUsecase _fetchSeatingAreasUsecase;
  final FetchRestaurantTablesUsecase _fetchTablesUsecase;
  final FetchRestaurantTimeSlotsUsecase _fetchTimeSlotsUsecase;
  final MakeReservationsUsecase _makeReservationUsecase;

  MakeReservationBloc(
    this._fetchSeatingAreasUsecase,
    this._fetchTablesUsecase,
    this._fetchTimeSlotsUsecase,
    this._makeReservationUsecase,
  ) : super(MakeReservationState(
          seatingAreaResponse: ApiResponse.initial(),
          tableResponse: ApiResponse.initial(),
          timeSlotResponse: ApiResponse.initial(),
          reservationResponse: ApiResponse.initial(),
        )) {
    on<FetchSeatingAreas>(_onFetchSeatingAreas);
    on<FetchTables>(_onFetchTables);
    on<FetchTimeSlots>(_onFetchTimeSlots);
    on<MakeReservation>(_onMakeReservation);
  }

  Future<void> _onFetchSeatingAreas(
      FetchSeatingAreas event, Emitter<MakeReservationState> emit) async {
    emit(state.copyWith(seatingAreaResponse: ApiResponse.loading()));
    final result = await _fetchSeatingAreasUsecase(event.id);

    switch (result) {
      case DataSuccess<List<RestaurantSeatingAreaEntity>>():
        emit(state.copyWith(
            seatingAreaResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure<List<RestaurantSeatingAreaEntity>>():
        emit(state.copyWith(
            seatingAreaResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(seatingAreaResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchTables(
      FetchTables event, Emitter<MakeReservationState> emit) async {
    emit(state.copyWith(tableResponse: ApiResponse.loading()));
    final result = await _fetchTablesUsecase(event.id);

    switch (result) {
      case DataSuccess<List<String>>():
        emit(state.copyWith(tableResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure<List<String>>():
        emit(state.copyWith(tableResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(tableResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchTimeSlots(
      FetchTimeSlots event, Emitter<MakeReservationState> emit) async {
    emit(state.copyWith(timeSlotResponse: ApiResponse.loading()));
    final result = await _fetchTimeSlotsUsecase(event.parms);

    switch (result) {
      case DataSuccess<RestaurantTimeSlotEntity>():
        emit(state.copyWith(
            timeSlotResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure<RestaurantTimeSlotEntity>():
        emit(state.copyWith(timeSlotResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(timeSlotResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onMakeReservation(
      MakeReservation event, Emitter<MakeReservationState> emit) async {
    emit(state.copyWith(reservationResponse: ApiResponse.loading()));
    final result = await _makeReservationUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(reservationResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure<String>():
        emit(state.copyWith(reservationResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(reservationResponse: ApiResponse.initial()));
    }
  }
}
