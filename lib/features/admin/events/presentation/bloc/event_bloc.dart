import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/entities/event.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/usecases/delete_event.dart';
import 'package:tasti_restaurant_app/features/admin/events/domain/usecases/fetch_events.dart';
import '/core/network/response.dart';
import 'event_event.dart';
import 'event_state.dart';

class EventBloc extends Bloc<EventEvents, EventState> {
  final FetchEventsUsecase _useCase;
  final DeleteEventUsecase _deleteUsecase;

  EventBloc(this._useCase, this._deleteUsecase)
      : super(EventState(
          fetchResponse: ApiResponse.initial(),
          deleteResponse: ApiResponse.initial(),
        )) {
    on<FetchInitialEvent>(_onFetchInitialEvent);
    on<FetchMoreEvent>(_onFetchMoreEvent);
    on<SearchEvents>(_onSearchEvents);
    on<AdminDeleteEvent>(_onAdminDeleteEvent);
  }

  Future<void> _onAdminDeleteEvent(
      AdminDeleteEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(deleteResponse: ApiResponse.loading()));
    try {
      final result = await _deleteUsecase.call(event.id.toString());
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList =
            oldList?.where((r) => r.eventId != event.id).toList();
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(List.from(optimisticList!)),
            deleteResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(deleteResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(deleteResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchInitialEvent(
      FetchInitialEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms = PaginationParms(page: '1', search: state.query);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<EventEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<EventEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onSearchEvents(
      SearchEvents event, Emitter<EventState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms =
          PaginationParms(page: '1', search: event.query);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<EventEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<EventEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchMoreEvent(
      FetchMoreEvent event, Emitter<EventState> emit) async {
    if (state.pagination!.hasNext && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      try {
        final nextPage = state.pagination!.currentPage + 1;
        final parms = PaginationParms(
            page: nextPage.toString(), search: state.query);
        final result = await _useCase.call(parms);

        if (result is DataSuccess<EventEntity>) {
          final newData = result.data;

          final updatedList =
              List<EventItem>.from(state.fetchResponse.data!)
                ..addAll(newData.data);

          emit(state.copyWith(
              fetchResponse: ApiResponse.completed(updatedList),
              pagination: newData.pagination,
              isLoadingMore: false));
        } else if (result is DataFailure<EventEntity>) {
          emit(state.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingMore: false));
      }
    }
  }
}
