import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/restaurant-admin/food_menu/data/models/menu.dart';
import '/features/restaurant-admin/food_menu/domain/usecases/add_menu.dart';
import '/features/restaurant-admin/food_menu/domain/usecases/fetch_menu.dart';
import '/core/network/response.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final FetchMenuUsecase _fetchUsecase;
  final AddMenuUsecase _addUsecase;

  MenuBloc(
    this._fetchUsecase,
    this._addUsecase,
  ) : super(MenuState(
          addResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
        )) {
    on<FetchMenuEvent>(_onFetchMenuEvent);
    on<AddMenuEvent>(_onAddMenuEvent);
  }

  Future<void> _onAddMenuEvent(
      AddMenuEvent event, Emitter<MenuState> emit) async {
    emit(state.copyWith(addResponse: ApiResponse.loading()));
    final result = await _addUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
        add(FetchMenuEvent(event.parms.id.toString()));
        emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
        break;

      case DataFailure():
        emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
        break;

      default:
        emit(state.copyWith(addResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchMenuEvent(
      FetchMenuEvent event, Emitter<MenuState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<MenuModel>():
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
