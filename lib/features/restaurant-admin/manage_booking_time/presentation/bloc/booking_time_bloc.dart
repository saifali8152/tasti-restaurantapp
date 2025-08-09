import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/features/common/auth/data/models/user.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/entities/booking_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/activate_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/deactivate_time.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/fetch_times_data.dart';
import 'package:tasti_restaurant_app/features/restaurant-admin/manage_booking_time/domain/usecases/update_time_duration.dart';
import '/core/network/response.dart';
import 'booking_time_event.dart';
import 'booking_time_state.dart';

class BookingTimeBloc extends Bloc<BookingTimeEvent, BookingTimeState> {
  final DeactivateTimeUsecase _deactivateUsecase;
  final ActivateTimeUsecase _activateUsecase;
  final FetchTimesDataUsecase _fetchUsecase;
  final UpdateTimeDurationUsecase _updateTimeUsecase;

  BookingTimeBloc(
    this._fetchUsecase,
    this._deactivateUsecase,
    this._activateUsecase,
    this._updateTimeUsecase,
  ) : super(BookingTimeState(
          deactivateResponse: ApiResponse.initial(),
          activateResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
          updateDurationResponse: ApiResponse.initial(),
        )) {
    on<FetchBookingTimeEvent>(_onFetchBookingTimeEvent);
    on<DeactivateBookingTimeEvent>(_onDeactivateBookingTimeEvent);
    on<ActivateBookingTimeEvent>(_onActivateBookingTimeEvent);
    on<UpdateDurationTimeEvent>(_onUpdateDurationTimeEvent);
  }

  Future<void> _onUpdateDurationTimeEvent(
      UpdateDurationTimeEvent event, Emitter<BookingTimeState> emit) async {
    emit(state.copyWith(updateDurationResponse: ApiResponse.loading()));
    final result = await _updateTimeUsecase(event.parms);

    switch (result) {
      case DataSuccess<String>():
      final currentUser = SessionController().user;
      final userModel = UserModel.fromEntity(currentUser!);

      final updatedUser = userModel.copyWith(restaurant: userModel.restaurant.copyWith(timeDuration: event.parms.timeDuration));
      await SessionController().saveUserSession(updatedUser.toEntity());
      
        emit(state.copyWith(updateDurationResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(updateDurationResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(updateDurationResponse: ApiResponse.initial()));
    }
  }
  
  Future<void> _onFetchBookingTimeEvent(
      FetchBookingTimeEvent event, Emitter<BookingTimeState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));
    final result = await _fetchUsecase(event.id);

    switch (result) {
      case DataSuccess<BookingTimeEntity>():
        emit(state.copyWith(fetchResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onActivateBookingTimeEvent(
  ActivateBookingTimeEvent event,
  Emitter<BookingTimeState> emit,
) async {
  final currentData = state.fetchResponse.data;

  if (currentData != null) {
    // Find the item in inactive list
    final itemIndex = currentData.inActive
        .indexWhere((e) => e.timeId == event.parms.timeId);

    if (itemIndex != -1) {
      final updatedInactive = List.of(currentData.inActive);
      final updatedActive = List.of(currentData.active);
      final updatedData = List.of(currentData.data);

      // Change status to "on" when moving to active
      final movedItem =
          updatedInactive.removeAt(itemIndex).copyWith(status: 'on');
      updatedActive.add(movedItem);

      // ✅ Update only the changed item in `data`
      final dataIndex =
          updatedData.indexWhere((e) => e.timeId == event.parms.timeId);
      if (dataIndex != -1) {
        updatedData[dataIndex] = movedItem;
      }

      final updatedEntity = currentData.copyWith(
        active: updatedActive,
        inActive: updatedInactive,
        data: updatedData,
      );

      // Emit optimistic UI update
      emit(state.copyWith(
        fetchResponse: ApiResponse.completed(updatedEntity),
        activateResponse: ApiResponse.loading(),
      ));

      // Call API in background
      final result = await _activateUsecase(event.parms);

      switch (result) {
        case DataSuccess<String>():
          emit(state.copyWith(
            activateResponse: ApiResponse.completed(result.data),
          ));
          break;

        case DataFailure():
          // Revert status back to "off" if activation fails
          final revertedInactive = List.of(updatedEntity.inActive)
            ..insert(itemIndex, movedItem.copyWith(status: 'off'));
          final revertedActive = List.of(updatedEntity.active)
            ..remove(movedItem);

          // ✅ Update only the changed item in `data` on revert
          final revertedData = List.of(updatedEntity.data);
          if (dataIndex != -1) {
            revertedData[dataIndex] = movedItem.copyWith(status: 'off');
          }

          final revertedEntity = currentData.copyWith(
            active: revertedActive,
            inActive: revertedInactive,
            data: revertedData,
          );

          emit(state.copyWith(
            fetchResponse: ApiResponse.completed(revertedEntity),
            activateResponse: ApiResponse.error(result.error),
          ));
          break;

        default:
          emit(state.copyWith(activateResponse: ApiResponse.initial()));
      }
    }
  }
}


  Future<void> _onDeactivateBookingTimeEvent(
  DeactivateBookingTimeEvent event,
  Emitter<BookingTimeState> emit,
) async {
  final currentData = state.fetchResponse.data;

  if (currentData != null) {
    final itemIndex =
        currentData.active.indexWhere((e) => e.timeId == event.parms.timeId);

    if (itemIndex != -1) {
      final updatedActive = List.of(currentData.active);
      final updatedInactive = List.of(currentData.inActive);
      final updatedData = List.of(currentData.data);

      // Change status to "off" when moving to inactive
      final movedItem =
          updatedActive.removeAt(itemIndex).copyWith(status: 'off');
      updatedInactive.add(movedItem);

      // ✅ Update only the changed item in `data`
      final dataIndex =
          updatedData.indexWhere((e) => e.timeId == event.parms.timeId);
      if (dataIndex != -1) {
        updatedData[dataIndex] = movedItem;
      }

      final updatedEntity = currentData.copyWith(
        active: updatedActive,
        inActive: updatedInactive,
        data: updatedData,
      );

      emit(state.copyWith(
        fetchResponse: ApiResponse.completed(updatedEntity),
        deactivateResponse: ApiResponse.loading(),
      ));

      final result = await _deactivateUsecase(event.parms);

      switch (result) {
        case DataSuccess<String>():
          emit(state.copyWith(
            deactivateResponse: ApiResponse.completed(result.data),
          ));
          break;

        case DataFailure():
          // Revert status back to "on" when restoring
          final revertedActive = List.of(updatedEntity.active)
            ..insert(itemIndex, movedItem.copyWith(status: 'on'));
          final revertedInactive = List.of(updatedEntity.inActive)
            ..remove(movedItem);

          // ✅ Update only the changed item in `data`
          final revertedData = List.of(updatedEntity.data);
          if (dataIndex != -1) {
            revertedData[dataIndex] = movedItem.copyWith(status: 'on');
          }

          final revertedEntity = currentData.copyWith(
            active: revertedActive,
            inActive: revertedInactive,
            data: revertedData,
          );

          emit(state.copyWith(
            fetchResponse: ApiResponse.completed(revertedEntity),
            deactivateResponse: ApiResponse.error(result.error),
          ));
          break;

        default:
          emit(state.copyWith(deactivateResponse: ApiResponse.initial()));
      }
    }
  }
}

}
