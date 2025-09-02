import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/domain/usecases/add_restaurant_user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/seating_area_event.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/restaurant_user/presentation/bloc/seating_area_state.dart';
import '/core/network/response.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddRestaurantUserUsecase _addUsecase;

  UserBloc(this._addUsecase)
      : super(UserState(addResponse: ApiResponse.initial())) {
    on<AddUserEvent>(_onAddUserEvent);
  }

  Future<void> _onAddUserEvent(AddUserEvent event, Emitter<UserState> emit) async {
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
}
