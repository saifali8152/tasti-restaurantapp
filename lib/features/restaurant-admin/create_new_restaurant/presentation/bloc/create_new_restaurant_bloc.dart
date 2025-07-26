import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/auth/data/models/user.dart';
import 'package:tasti_restaurant_app/features/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/location_model.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/data/models/prediction_model.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/location_entity.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/entities/prediction_entity.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/create_new_restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/get_location_usecase.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/get_predictions_usecase.dart';
import 'package:tasti_restaurant_app/features/skaleton/user_cubit/skaleton_cubit.dart';
import '/core/network/response.dart';
import 'create_new_restaurant_event.dart';
import 'create_new_restaurant_state.dart';

class CreateNewRestaurantBloc
    extends Bloc<CreateNewRestaurantEvent, CreateNewRestaurantState> {
  final CreateNewRestaurantUsecase _usecase;
  final GetPlacePredictionsUseCase getPlacePredictionsUseCase;
  final GetPlaceDetailsUseCase getPlaceDetailsUseCase;

  CreateNewRestaurantBloc(this._usecase, this.getPlaceDetailsUseCase,
      this.getPlacePredictionsUseCase)
      : super(CreateNewRestaurantState(
          createRestaurantResponse: ApiResponse.initial(),
          locationResponse: ApiResponse.initial(),
        )) {
    on<PhoneNumberChanged>(_onPhoneNumberChanged);
    on<CreateNewRestaurantSubmitted>(_onCreateNewRestaurantSubmitted);
    on<LocationChanged>(_onLocationChanged);
    on<SelectLocation>(_onLocationSet);
  }

  Future<void> _onLocationSet(
      SelectLocation event, Emitter<CreateNewRestaurantState> emit) async {
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
          city: response.data.city
        );

        emit(state.copyWith(location: location));
      }
    } catch (e) {
      log("Location fetch error: $e");
      emit(state.copyWith(locationResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onLocationChanged(
      LocationChanged event, Emitter<CreateNewRestaurantState> emit) async {
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

  void _onPhoneNumberChanged(
      PhoneNumberChanged event, Emitter<CreateNewRestaurantState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  Future<void> _onCreateNewRestaurantSubmitted(
      CreateNewRestaurantSubmitted event,
      Emitter<CreateNewRestaurantState> emit) async {
    emit(state.copyWith(createRestaurantResponse: ApiResponse.loading()));
    final result = await _usecase(event.parms);

    switch (result) {
      case DataSuccess<UserRestaurantEntity>():
        final user = UserModel.fromEntity(SessionController().user!);
        final updatedUser = user.copyWith(restaurant: result.data, subscriptionStatus: 'inactive');

        await SessionController().saveUserSession(updatedUser);
        sl<UserCubit>().setUser(updatedUser);
        emit(state.copyWith(createRestaurantResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            createRestaurantResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(createRestaurantResponse: ApiResponse.initial()));
    }
  }
}
