import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/data/models/venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/usecases/add_venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/usecases/delete_venue.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/set_venue_category/domain/usecases/fetch_venue.dart';
import '/core/network/response.dart';
import 'venue_event.dart';
import 'venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final FetchVenueUsecase _fetchUsecase;
  final DeleteVenueUsecase _deleteUsecase;
  final AddVenueUsecase _addUsecase;

  VenueBloc(
    this._fetchUsecase,
    this._deleteUsecase,
    this._addUsecase,
  ) : super(VenueState(
          addVenues: ApiResponse.initial(),
          fetchVenues: ApiResponse.initial(),
          deleteVenues: ApiResponse.initial(),
        )) {
    on<FetchVenueEvent>(_onFetchVenueEvent);
    on<DeleteVenueEvent>(_onDeleteVenueEvent);
    on<AddVenueEvent>(_onAddVenueEvent);
  }

  Future<void> _onAddVenueEvent(
      AddVenueEvent event, Emitter<VenueState> emit) async {
    emit(state.copyWith(addVenues: ApiResponse.loading()));
    final result = await _addUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        // Check if we already have data
        if (state.fetchVenues.data == null) {
          // First time adding a venue → refetch from API to populate UI
          emit(state.copyWith(addVenues: ApiResponse.completed(result.data)));
          add(FetchVenueEvent(event.parms.id.toString()));
        } else {
          // Update existing venue locally
          final updatedData = state.fetchVenues.data!.copyWith(
            name: event.parms.names,
          );

          emit(
            state.copyWith(
              addVenues: ApiResponse.completed(result.data),
              fetchVenues: ApiResponse.completed(updatedData),
            ),
          );
        }
        break;

      case DataFailure():
        emit(state.copyWith(addVenues: ApiResponse.error(result.error)));
        break;

      default:
        emit(state.copyWith(addVenues: ApiResponse.initial()));
    }
  }

  Future<void> _onDeleteVenueEvent(
      DeleteVenueEvent event, Emitter<VenueState> emit) async {
    emit(state.copyWith(deleteVenues: ApiResponse.loading()));
    final result = await _deleteUsecase(event.id);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(
            deleteVenues: ApiResponse.completed(result.data),
            fetchVenues: ApiResponse.completed(null)));
        break;
      case DataFailure():
        emit(state.copyWith(deleteVenues: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(deleteVenues: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchVenueEvent(
      FetchVenueEvent event, Emitter<VenueState> emit) async {
    emit(state.copyWith(fetchVenues: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<VenueModel>():
        emit(state.copyWith(fetchVenues: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchVenues: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchVenues: ApiResponse.initial()));
    }
  }
}
