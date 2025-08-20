import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/restaurant-admin/gallery/domain/entities/gallery.dart';
import '/features/restaurant-admin/gallery/domain/usecases/add_gallery.dart';
import '/features/restaurant-admin/gallery/domain/usecases/delete_gallery.dart';
import '/features/restaurant-admin/gallery/domain/usecases/fetch_gallery.dart';
import '/core/network/response.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final DeleteGalleryUsecase _deleteUsecase;
  final AddGalleryUsecase _addUsecase;
  final FetchGalleryUsecase _fetchUsecase;

  GalleryBloc(
    this._fetchUsecase,
    this._deleteUsecase,
    this._addUsecase,
  ) : super(GalleryState(
          deleteResponse: ApiResponse.initial(),
          addResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
        )) {
    on<FetchGalleryEvent>(_onFetchGalleryEvent);
    on<DeleteGalleryEvent>(_onDeleteGalleryEvent);
    on<AddGalleryEvent>(_onAddGalleryEvent);
  }

  Future<void> _onFetchGalleryEvent(
      FetchGalleryEvent event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<List<GalleryEntity>>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onAddGalleryEvent(
    AddGalleryEvent event, Emitter<GalleryState> emit) async {
  emit(state.copyWith(addResponse: ApiResponse.loading()));
  final result = await _addUsecase(event.parms);

  switch (result) {
    case DataSuccess<String>():
      add(FetchGalleryEvent(event.parms.id.toString()));
      emit(state.copyWith(addResponse: ApiResponse.completed(result.data)));
      break;

    case DataFailure():
      emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
      break;

    default:
      emit(state.copyWith(addResponse: ApiResponse.initial()));
  }
}


  Future<void> _onDeleteGalleryEvent(
      DeleteGalleryEvent event, Emitter<GalleryState> emit) async {
    emit(state.copyWith(deleteResponse: ApiResponse.loading()));
    final result = await _deleteUsecase(event.id);

    switch (result) {
      case DataSuccess<String>():
      final updatedData = state.fetchResponse.data?.where((gallery)=> gallery.id != event.id).toList();
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
