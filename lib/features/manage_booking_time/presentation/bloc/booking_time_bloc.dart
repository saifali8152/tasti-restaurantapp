import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/domain/entities/booking_time.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/domain/usecases/activate_time.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/domain/usecases/deactivate_time.dart';
import 'package:tasti_restaurant_app/features/manage_booking_time/domain/usecases/fetch_times_data.dart';
import '/core/network/response.dart';
import 'booking_time_event.dart';
import 'booking_time_state.dart';

class BookingTimeBloc extends Bloc<BookingTimeEvent, BookingTimeState> {
  final DeactivateTimeUsecase _deactivateUsecase;
  final ActivateTimeUsecase _activateUsecase;
  final FetchTimesDataUsecase _fetchUsecase;

  BookingTimeBloc(
    this._fetchUsecase,
    this._deactivateUsecase,
    this._activateUsecase,
  ) : super(BookingTimeState(
          deactivateResponse: ApiResponse.initial(),
          activateResponse: ApiResponse.initial(),
          fetchResponse: ApiResponse.initial(),
        )) {
    on<FetchBookingTimeEvent>(_onFetchBookingTimeEvent);
    on<DeactivateBookingTimeEvent>(_onDeactivateBookingTimeEvent);
    on<ActivateBookingTimeEvent>(_onActivateBookingTimeEvent);
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

        // Change status to "on" when moving to active
        final movedItem =
            updatedInactive.removeAt(itemIndex).copyWith(status: 'on');
        updatedActive.add(movedItem);

        final updatedEntity = currentData.copyWith(
          active: updatedActive,
          inActive: updatedInactive,
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

            final revertedEntity = currentData.copyWith(
              active: revertedActive,
              inActive: revertedInactive,
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

        // Change status to "off" when moving to inactive
        final movedItem =
            updatedActive.removeAt(itemIndex).copyWith(status: 'off');
        updatedInactive.add(movedItem);

        final updatedEntity = currentData.copyWith(
          active: updatedActive,
          inActive: updatedInactive,
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

            final revertedEntity = currentData.copyWith(
              active: revertedActive,
              inActive: revertedInactive,
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
