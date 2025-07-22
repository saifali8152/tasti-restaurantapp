import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/entities/requests.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/usecases/delete_today_requests.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/usecases/fetch_requests.dart';
import '/core/network/response.dart';
import 'today_request_event.dart';
import 'today_request_state.dart';

class TodayRequestBloc extends Bloc<TodayRequestEvents, TodayRequestState> {
  final FetchTodayRequestUsecase _useCase;
  final DeleteTodayRequestUsecase _deleteUsecase;


  TodayRequestBloc(this._useCase, this._deleteUsecase)
      : super(TodayRequestState(
            fetchResponse: ApiResponse.initial(),
            deleteResponse: ApiResponse.initial(),
            )) {
    on<FetchInitialTodayRequests>(_onFetchInitialTodayRequests);
    on<FetchMoreTodayRequests>(_onFetchMoreTodayRequests);
    on<SearchTodayRequests>(_onSearchTodayRequests);
    on<AdminDeleteTodayRequest>(_onAdminDeleteTodayRequest);
  }

  Future<void> _onAdminDeleteTodayRequest(
      AdminDeleteTodayRequest event, Emitter<TodayRequestState> emit) async {
    emit(state.copyWith(deleteResponse: ApiResponse.loading()));
    try {
      final result = await _deleteUsecase.call(event.id.toString());
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList = oldList?.where((r) => r.reqId != event.id).toList();
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

  Future<void> _onFetchInitialTodayRequests(
      FetchInitialTodayRequests event, Emitter<TodayRequestState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms = RequestParms(
        page: '1',
        search: state.query,
        type: event.type,
      );
      
      final result = await _useCase.call(parms);

      if (result is DataSuccess<RequestEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<RequestEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }
  
  Future<void> _onSearchTodayRequests(
      SearchTodayRequests event, Emitter<TodayRequestState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms = RequestParms(
        page: '1',
        search: event.query,
        type: event.type,
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<RequestEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<RequestEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchMoreTodayRequests(
      FetchMoreTodayRequests event, Emitter<TodayRequestState> emit) async {
    if (state.pagination!.hasNext && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      try {
        final nextPage = state.pagination!.currentPage + 1;
        final parms = RequestParms(
          page: nextPage.toString(),
          search: state.query,
          type: event.type
        );
        final result = await _useCase.call(parms);

        if (result is DataSuccess<RequestEntity>) {
          final newData = result.data;

          final updatedList = List<RequestItem>.from(state.fetchResponse.data!)
            ..addAll(newData.data);

          emit(state.copyWith(
              fetchResponse: ApiResponse.completed(updatedList),
              pagination: newData.pagination,
              isLoadingMore: false));
        } else if (result is DataFailure<RequestEntity>) {
          emit(state.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingMore: false));
      }
    }
  }
}
