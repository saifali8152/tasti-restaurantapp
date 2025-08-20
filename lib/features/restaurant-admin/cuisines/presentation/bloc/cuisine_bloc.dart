import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/restaurant-admin/cuisines/domain/entities/cuisine.dart';
import '/features/restaurant-admin/cuisines/domain/usecases/add_cuisine.dart';
import '/features/restaurant-admin/cuisines/domain/usecases/delete_cuisine.dart';
import '/features/restaurant-admin/cuisines/domain/usecases/fetch_cuisine.dart';
import '/core/network/response.dart';
import 'cuisine_event.dart';
import 'cuisine_state.dart';

class CuisineBloc extends Bloc<CuisineEvent, CuisineState> {
  final DeleteCuisineUsecase _deleteUsecase;
  final AddCuisineUsecase _addUsecase;
  final FetchCuisineUsecase _fetchUsecase;

  CuisineBloc(
    this._fetchUsecase,
    this._deleteUsecase,
    this._addUsecase,
  ) : super(CuisineState(
          deleteCuisine: ApiResponse.initial(),
          addCuisine: ApiResponse.initial(),
          fetchCuisine: ApiResponse.initial(),
        )) {
    on<FetchCuisineEvent>(_onFetchCuisineEvent);
    on<DeleteCuisineEvent>(_onDeleteCuisineEvent);
    on<AddCuisineEvent>(_onAddCuisineEvent);
  }

  Future<void> _onFetchCuisineEvent(
      FetchCuisineEvent event, Emitter<CuisineState> emit) async {
    emit(state.copyWith(fetchCuisine: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<List<CuisineEntity>>():
        emit(state.copyWith(fetchCuisine: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchCuisine: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchCuisine: ApiResponse.initial()));
    }
  }

  Future<void> _onAddCuisineEvent(
    AddCuisineEvent event, Emitter<CuisineState> emit) async {
  emit(state.copyWith(addCuisine: ApiResponse.loading()));
  final result = await _addUsecase(event.parms);

  switch (result) {
    case DataSuccess<String>():
      add(FetchCuisineEvent(event.parms.id.toString()));
      emit(state.copyWith(addCuisine: ApiResponse.completed(result.data)));
      break;

    case DataFailure():
      emit(state.copyWith(addCuisine: ApiResponse.error(result.error)));
      break;

    default:
      emit(state.copyWith(addCuisine: ApiResponse.initial()));
  }
}


  Future<void> _onDeleteCuisineEvent(
      DeleteCuisineEvent event, Emitter<CuisineState> emit) async {
    emit(state.copyWith(deleteCuisine: ApiResponse.loading()));
    final result = await _deleteUsecase(event.id);

    switch (result) {
      case DataSuccess<String>():
      final updatedData = state.fetchCuisine.data?.where((cuisine)=> cuisine.typeId != event.id).toList();
        emit(state.copyWith(
          deleteCuisine: ApiResponse.completed(result.data),
          fetchCuisine: ApiResponse.completed(updatedData),
        ));
        break;
      case DataFailure():
        emit(state.copyWith(deleteCuisine: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(deleteCuisine: ApiResponse.initial()));
    }
  }
}
