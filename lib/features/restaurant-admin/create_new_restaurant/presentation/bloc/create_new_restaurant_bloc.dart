import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/dependency_injection.dart';
import 'package:tasti_restaurant_app/features/common/auth/data/models/user.dart';
import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/create_new_restaurant.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/create_new_restaurant/domain/usecases/update_restaurant.dart';
import 'package:tasti_restaurant_app/features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/core/network/response.dart';
import 'create_new_restaurant_event.dart';
import 'create_new_restaurant_state.dart';

class CreateNewRestaurantBloc
    extends Bloc<CreateNewRestaurantEvent, CreateNewRestaurantState> {
  final CreateNewRestaurantUsecase _usecase;
  final UpdateRestaurantUsecase _updateUsecase;

  CreateNewRestaurantBloc(
    this._usecase,
    this._updateUsecase,
  ) : super(CreateNewRestaurantState(
          createRestaurantResponse: ApiResponse.initial(),
          updateRestaurantResponse: ApiResponse.initial(),
        )) {
    on<CreateNewRestaurantSubmitted>(_onCreateNewRestaurantSubmitted);
    on<UpdateNewRestaurantSubmitted>(_onUpdateNewRestaurantSubmitted);
  }

  Future<void> _onCreateNewRestaurantSubmitted(
      CreateNewRestaurantSubmitted event,
      Emitter<CreateNewRestaurantState> emit) async {
    emit(state.copyWith(createRestaurantResponse: ApiResponse.loading()));
    final result = await _usecase(event.parms);

    switch (result) {
      case DataSuccess<UserRestaurantEntity>():
        final user = UserModel.fromEntity(SessionController().user!);
        final updatedUser = user.copyWith(
            restaurant: result.data, subscriptionStatus: 'inactive');

        await SessionController().saveUserSession(updatedUser);
        sl<UserCubit>().setUser(updatedUser);
        emit(state.copyWith(
            createRestaurantResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            createRestaurantResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(createRestaurantResponse: ApiResponse.initial()));
    }
  }
  
  Future<void> _onUpdateNewRestaurantSubmitted(
      UpdateNewRestaurantSubmitted event,
      Emitter<CreateNewRestaurantState> emit) async {
    emit(state.copyWith(updateRestaurantResponse: ApiResponse.loading()));
    final result = await _updateUsecase(event.parms);

    switch (result) {
      case DataSuccess<UserRestaurantEntity>():
        final user = UserModel.fromEntity(SessionController().user!);
        final updatedUser = user.copyWith(restaurant: result.data);

        await SessionController().saveUserSession(updatedUser);
        sl<UserCubit>().setUser(updatedUser);
        emit(state.copyWith(
            updateRestaurantResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            updateRestaurantResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(updateRestaurantResponse: ApiResponse.initial()));
    }
  }
}
