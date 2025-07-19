import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/entities/today_queries.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/usecases/delete_today_queries.dart';
import 'package:tasti_restaurant_app/features/admin/today_queries/domain/usecases/fetch_today_queries.dart';
import '/core/network/response.dart';
import 'today_queries_event.dart';
import 'today_queries_state.dart';

class TodayqueriesBloc extends Bloc<TodayqueriesEvents, TodayQueriesState> {
  final FetchTodayQueriesUsecase _useCase;
  final DeleteTodayQueriesUsecase _deleteUsecase;


  TodayqueriesBloc(this._useCase, this._deleteUsecase)
      : super(TodayQueriesState(
            fetchResponse: ApiResponse.initial(),
            deleteResponse: ApiResponse.initial(),
            )) {
    on<FetchInitialTodayqueriess>(_onFetchInitialTodayqueriess);
    on<FetchMoreTodayqueriess>(_onFetchMoreTodayqueriess);
    on<SearchTodayqueriess>(_onSearchTodayqueriess);
    on<AdminDeleteTodayqueries>(_onAdminDeleteTodayqueries);
  }

  Future<void> _onAdminDeleteTodayqueries(
      AdminDeleteTodayqueries event, Emitter<TodayQueriesState> emit) async {
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

  Future<void> _onFetchInitialTodayqueriess(
      FetchInitialTodayqueriess event, Emitter<TodayQueriesState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms = PaginationParms(
        page: '1',
        search: state.query,
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<TodayQueriesEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<TodayQueriesEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }
  
  Future<void> _onSearchTodayqueriess(
      SearchTodayqueriess event, Emitter<TodayQueriesState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms = PaginationParms(
        page: '1',
        search: event.query,
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<TodayQueriesEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<TodayQueriesEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchMoreTodayqueriess(
      FetchMoreTodayqueriess event, Emitter<TodayQueriesState> emit) async {
    if (state.pagination!.hasNext && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      try {
        final nextPage = state.pagination!.currentPage + 1;
        final parms = PaginationParms(
          page: nextPage.toString(),
          search: state.query,
        );
        final result = await _useCase.call(parms);

        if (result is DataSuccess<TodayQueriesEntity>) {
          final newData = result.data;

          final updatedList = List<TodayQueriesItem>.from(state.fetchResponse.data!)
            ..addAll(newData.data);

          emit(state.copyWith(
              fetchResponse: ApiResponse.completed(updatedList),
              pagination: newData.pagination,
              isLoadingMore: false));
        } else if (result is DataFailure<TodayQueriesEntity>) {
          emit(state.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingMore: false));
      }
    }
  }
}
