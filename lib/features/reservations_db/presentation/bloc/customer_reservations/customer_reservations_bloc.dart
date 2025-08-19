import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/csv_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/reservation_data_email.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/entities/resevation_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/usecases/fetch_csv_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/usecases/fetch_reservation_data.dart';
import 'package:tasti_restaurant_app/features/reservations_db/domain/usecases/fetch_reservation_data_by_email.dart';
import '/core/network/response.dart';
import 'customer_reservations_event.dart';
import 'customer_reservations_state.dart';

class CustomerReservationsBloc
    extends Bloc<CustomerReservationsEvent, CustomerReservationsState> {
  final FetchCsvDataUsecase _fetchCSVUsecase;
  final FetchReservationDataByEmailUsecase _fetchReservationByEmailUsecase;
  final FetchReservationDataUsecase _fetchReservationUsecase;

  CustomerReservationsBloc(
    this._fetchCSVUsecase,
    this._fetchReservationUsecase,
    this._fetchReservationByEmailUsecase,
  ) : super(CustomerReservationsState(
          fetchCSVResponse: ApiResponse.initial(),
          fetchRevervationResponse: ApiResponse.initial(),
          fetchRevervationByEmailResponse: ApiResponse.initial(),
        )) {
    on<FetchCsvDataEvent>(_onFetchCsvDataEvent);
    on<FetchReservationDataByEmailEvent>(_onFetchReservationDataByEvent);
    on<FetchReservationEvent>(_onFetchReservationEvent);
  }

  Future<void> _onFetchCsvDataEvent(
      FetchCsvDataEvent event,
      Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(fetchCSVResponse: ApiResponse.loading()));
    final result = await _fetchCSVUsecase(event.id);

    switch (result) {
      case DataSuccess<List<CSVDataEntity>>():
        emit(state.copyWith(fetchCSVResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchCSVResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchCSVResponse: ApiResponse.initial()));
    }
  }
  Future<void> _onFetchReservationDataByEvent(
      FetchReservationDataByEmailEvent event,
      Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(fetchRevervationByEmailResponse: ApiResponse.loading()));
    final result = await _fetchReservationByEmailUsecase(event.parms);

    switch (result) {
      case DataSuccess<List<ReservationDataEmailEntity>>():
        emit(state.copyWith(fetchRevervationByEmailResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchRevervationByEmailResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchRevervationByEmailResponse: ApiResponse.initial()));
    }
  }
  Future<void> _onFetchReservationEvent(
      FetchReservationEvent event,
      Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(fetchRevervationResponse: ApiResponse.loading()));
    final result = await _fetchReservationUsecase(event.id);

    switch (result) {
      case DataSuccess<List<ReservationDataEntity>>():
        emit(state.copyWith(fetchRevervationResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchRevervationResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchRevervationResponse: ApiResponse.initial()));
    }
  }
}
