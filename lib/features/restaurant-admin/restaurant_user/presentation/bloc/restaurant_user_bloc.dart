import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/entities/restaurant_user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/usecases/add_restaurant_user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/usecases/fetch_restaurant_user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/restaurant_user_state.dart';
import '/core/network/response.dart';

class RestaurantUserBloc extends Bloc<RestaurantUserEvent, RestaurantUserState> {
  final AddRestaurantUserUsecase _addUsecase;
  final FetchRestaurantUserUsecase _fetchUsecase;

  RestaurantUserBloc(this._addUsecase, this._fetchUsecase)
      : super(RestaurantUserState(addResponse: ApiResponse.initial(), fetchResponse: ApiResponse.initial())) {
    on<AddRestaurantUserEvent>(_onAddRestaurantUserEvent);
    on<FetchRestaurantUserEvent>(_onFetchRestaurantUserEvent);
  }

  Future<void> _onAddRestaurantUserEvent(AddRestaurantUserEvent event, Emitter<RestaurantUserState> emit) async {
    emit(state.copyWith(addResponse: ApiResponse.loading()));
    final result = await _addUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(addResponse: ApiResponse.initial()));
    }
  }
  
  Future<void> _onFetchRestaurantUserEvent(FetchRestaurantUserEvent event, Emitter<RestaurantUserState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<List<RestaurantUserEntity>>():
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
