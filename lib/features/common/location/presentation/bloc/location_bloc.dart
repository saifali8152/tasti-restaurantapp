import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/common/location/data/models/location_model.dart';
import 'package:tasti_restaurant_app/features/common/location/data/models/prediction_model.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/entities/prediction_entity.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/usecases/get_location_usecase.dart';
import 'package:tasti_restaurant_app/features/common/location/domain/usecases/get_predictions_usecase.dart';
import '/core/network/response.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetPlacePredictionsUseCase getPlacePredictionsUseCase;
  final GetPlaceDetailsUseCase getPlaceDetailsUseCase;

  LocationBloc(
    this.getPlaceDetailsUseCase,
    this.getPlacePredictionsUseCase,
  ) : super(LocationState(
          locationResponse: ApiResponse.initial(),
        )) {
    on<LocationChanged>(_onLocationChanged);
    on<SelectLocation>(_onLocationSet);
    on<SetLocationValues>((event, emit) {
      emit(state.copyWith(
        location: event.location,
        locationSet: true,
        selectedLocation: PredictionModel(
          placeId: '', // empty since no API call
          description: event.description,
        ),
        locationAddress: event.description,
      ));
    });
  }

  Future<void> _onLocationSet(
      SelectLocation event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
        locationSet: event.locationSet,
        selectedLocation: event.selectedLocation));
    try {
      final GetPlaceDetailsParms params = GetPlaceDetailsParms(
        placeId: event.selectedLocation!.placeId,
      );

      final response = await getPlaceDetailsUseCase.call(params);

      if (response is DataSuccess<LocationEntity>) {
        final LocationModel location = LocationModel(
            lat: response.data.lat,
            lng: response.data.lng,
            city: response.data.city);

        emit(state.copyWith(location: location));
      }
    } catch (e) {
      log("Location fetch error: $e");
      emit(state.copyWith(locationResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onLocationChanged(
      LocationChanged event, Emitter<LocationState> emit) async {
    emit(
      state.copyWith(
        locationResponse: ApiResponse.loading(),
        locationAddress: event.location,
        locationSet: false,
      ),
    );

    try {
      final query = event.location.trim();
      if (query.isEmpty) {
        emit(state.copyWith(locationResponse: ApiResponse.completed([])));
        return;
      }
      final GetPlacePredictionParms params = GetPlacePredictionParms(
        query: query,
      );

      final response = await getPlacePredictionsUseCase.call(params);

      if (response is DataSuccess<List<PredictionEntity>>) {
        final List<PredictionModel> predictions = (response.data)
            .map((item) => PredictionModel(
                  placeId: item.placeId,
                  description: item.description,
                ))
            .toList();
        emit(state.copyWith(
            locationResponse: ApiResponse.completed(predictions)));
      }
    } catch (e) {
      log("Location fetch error: $e");
      emit(state.copyWith(locationResponse: ApiResponse.error(e.toString())));
    }
  }
}
