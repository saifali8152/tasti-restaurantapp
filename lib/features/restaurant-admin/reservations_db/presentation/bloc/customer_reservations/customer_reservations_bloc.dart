import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/entities/csv_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/entities/reservation_data_email.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/entities/resevation_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/usecases/fetch_csv_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/usecases/fetch_reservation_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/usecases/fetch_reservation_data_by_email.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/usecases/fetch_sms_availability.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/usecases/send_csv_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/reservations_db/domain/usecases/send_restaurant_data.dart';
import '/core/network/response.dart';
import 'customer_reservations_event.dart';
import 'customer_reservations_state.dart';

class CustomerReservationsBloc
    extends Bloc<CustomerReservationsEvent, CustomerReservationsState> {
  final FetchCsvDataUsecase _fetchCSVUsecase;
  final FetchReservationDataByEmailUsecase _fetchReservationByEmailUsecase;
  final FetchReservationDataUsecase _fetchReservationUsecase;
  final FetchSmsAvailabilityUsecase _fetchSmsAvailabilityUsecase;
  final SendRestaurantDataUsecase _sendUsecase;
  final SendCsvDataUsecase _sendCSVUsecase;

  CustomerReservationsBloc(
    this._fetchCSVUsecase,
    this._fetchReservationUsecase,
    this._fetchReservationByEmailUsecase,
    this._fetchSmsAvailabilityUsecase,
    this._sendUsecase,
    this._sendCSVUsecase,
  ) : super(CustomerReservationsState(
          sendResponse: ApiResponse.initial(),
          sendCSVResponse: ApiResponse.initial(),
          fetchCSVResponse: ApiResponse.initial(),
          fetchRevervationResponse: ApiResponse.initial(),
          fetchRevervationByEmailResponse: ApiResponse.initial(),
          fetchSmsAvailabilityResponse: ApiResponse.initial(),
          selectedCVCRevervations: [],
          selectedRevervations: [],
        )) {
    on<FetchCsvDataEvent>(_onFetchCsvDataEvent);
    on<FetchReservationDataByEmailEvent>(_onFetchReservationDataByEvent);
    on<FetchReservationEvent>(_onFetchReservationEvent);
    on<FetchSmsAvailability>(_onFetchSmsAvailability);
    on<SendData>(_onSendData);
    on<SendCSVData>(_onSendCSVData);
    on<ToggleCSVReservationSelectionEvent>((event, emit) {
      final updatedList =
          List<CSVDataEntity>.from(state.selectedCVCRevervations);

      if (updatedList.contains(event.reservation)) {
        updatedList.remove(event.reservation);
      } else {
        updatedList.add(event.reservation);
      }

      emit(state.copyWith(selectedCVCRevervations: updatedList));
    });

    on<ToggleReservationSelectionEvent>((event, emit) {
      // copy current selected list
      final updatedList =
          List<ReservationDataEntity>.from(state.selectedRevervations);

      // check if this reservation is already selected
      if (updatedList.contains(event.reservation)) {
        // remove it
        updatedList.remove(event.reservation);
      } else {
        // add it
        updatedList.add(event.reservation);
      }

      // emit new state
      emit(state.copyWith(selectedRevervations: updatedList));
    });
  }

  Future<void> _onFetchSmsAvailability(FetchSmsAvailability event,
      Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(fetchSmsAvailabilityResponse: ApiResponse.loading()));
    final result = await _fetchSmsAvailabilityUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(
            fetchSmsAvailabilityResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            fetchSmsAvailabilityResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(
            fetchSmsAvailabilityResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onSendData(
      SendData event, Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(sendResponse: ApiResponse.loading()));
    final result = await _sendUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(sendResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(sendResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(sendResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onSendCSVData(
      SendCSVData event, Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(sendCSVResponse: ApiResponse.loading()));
    final result = await _sendCSVUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(
            sendCSVResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(sendCSVResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(sendCSVResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchCsvDataEvent(
      FetchCsvDataEvent event, Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(
        fetchCSVResponse: ApiResponse.loading(), selectedCVCRevervations: []));
    final result = await _fetchCSVUsecase(event.id);

    switch (result) {
      case DataSuccess<List<CSVDataEntity>>():
        emit(state.copyWith(
            fetchCSVResponse: ApiResponse.completed(result.data)));
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
    emit(
        state.copyWith(fetchRevervationByEmailResponse: ApiResponse.loading()));
    final result = await _fetchReservationByEmailUsecase(event.parms);

    switch (result) {
      case DataSuccess<List<ReservationDataEmailEntity>>():
        emit(state.copyWith(
            fetchRevervationByEmailResponse:
                ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            fetchRevervationByEmailResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(
            fetchRevervationByEmailResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchReservationEvent(FetchReservationEvent event,
      Emitter<CustomerReservationsState> emit) async {
    emit(state.copyWith(
        fetchRevervationResponse: ApiResponse.loading(),
        selectedRevervations: []));
    final result = await _fetchReservationUsecase(event.id);

    switch (result) {
      case DataSuccess<List<ReservationDataEntity>>():
        emit(state.copyWith(
            fetchRevervationResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            fetchRevervationResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchRevervationResponse: ApiResponse.initial()));
    }
  }
}
