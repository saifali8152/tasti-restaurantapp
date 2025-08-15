import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/entities/seating_area.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/usecases/add_seating_area.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/usecases/delete_seating_area.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/usecases/fetch_seating_area.dart';
import 'package:tasti_restaurant_app/features/seating_area/domain/usecases/update_seating_area.dart';
import '/core/network/response.dart';
import 'seating_area_event.dart';
import 'seating_area_state.dart';

class SeatingAreaBloc extends Bloc<SeatingAreaEvent, SeatingAreaState> {
  final DeleteSeatingAreaUsecase _deleteUsecase;
  final AddSeatingAreaUsecase _addUsecase;
  final UpdateSeatingAreaUsecase _updateUsecase;
  final FetchSeatingAreaUsecase _fetchUsecase;

  SeatingAreaBloc(
    this._fetchUsecase,
    this._deleteUsecase,
    this._addUsecase,
    this._updateUsecase,
  ) : super(SeatingAreaState(
          deleteResponse: ApiResponse.initial(),
          addResponse: ApiResponse.initial(),
          updateResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
        )) {
    on<FetchSeatingAreaEvent>(_onFetchSeatingAreaEvent);
    on<DeleteSeatingAreaEvent>(_onDeleteSeatingAreaEvent);
    on<AddSeatingAreaEvent>(_onAddSeatingAreaEvent);
    on<UpdateSeatingAreaEvent>(_onUpdateSeatingAreaEvent);
  }

  Future<void> _onFetchSeatingAreaEvent(
      FetchSeatingAreaEvent event, Emitter<SeatingAreaState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<List<SeatingAreaEntity>>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onAddSeatingAreaEvent(
    AddSeatingAreaEvent event, Emitter<SeatingAreaState> emit) async {
  emit(state.copyWith(addResponse: ApiResponse.loading()));
  final result = await _addUsecase(event.parms);

  switch (result) {
    case DataSuccess<String>():
      add(FetchSeatingAreaEvent(event.parms.restaurantId.toString()));
      emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
      break;

    case DataFailure():
      emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
      break;

    default:
      emit(state.copyWith(addResponse: ApiResponse.initial()));
  }
}
  
  Future<void> _onUpdateSeatingAreaEvent(
    UpdateSeatingAreaEvent event, Emitter<SeatingAreaState> emit) async {
  emit(state.copyWith(addResponse: ApiResponse.loading()));
  final result = await _updateUsecase(event.parms);

  switch (result) {
    case DataSuccess<String>():
      add(FetchSeatingAreaEvent(event.parms.restaurantId.toString()));
      emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
      break;

    case DataFailure():
      emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
      break;

    default:
      emit(state.copyWith(addResponse: ApiResponse.initial()));
  }
}


  Future<void> _onDeleteSeatingAreaEvent(
      DeleteSeatingAreaEvent event, Emitter<SeatingAreaState> emit) async {
    emit(state.copyWith(deleteResponse: ApiResponse.loading()));
    final result = await _deleteUsecase(event.id.toString());

    switch (result) {
      case DataSuccess<String>():
      final updatedData = state.fetchResponse.data?.where((seatingArea)=> seatingArea.id != event.id).toList();
        emit(state.copyWith(
          deleteResponse: ApiResponse.completed(result.data),
          fetchResponse: ApiResponse.completed(updatedData),
        ));
        break;
      case DataFailure():
        emit(state.copyWith(deleteResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(deleteResponse: ApiResponse.initial()));
    }
  }
}
