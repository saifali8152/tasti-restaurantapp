import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/entities/queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/usecases/delete_queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/usecases/fetch_queries.dart';
import 'package:tasti_restaurant_app/features/admin/queries/domain/usecases/reply_query.dart';
import '/core/network/response.dart';
import 'queries_event.dart';
import 'queries_state.dart';

class QueriesBloc extends Bloc<QueriesEvents, QueriesState> {
  final FetchQueriesUsecase _useCase;
  final DeleteQueriesUsecase _deleteUsecase;
  final ReplyQueryUsecase _replyUsecase;

  QueriesBloc(this._useCase, this._deleteUsecase, this._replyUsecase)
      : super(QueriesState(
          fetchResponse: ApiResponse.initial(),
          deleteResponse: ApiResponse.initial(),
          replyResponse: ApiResponse.initial(),
        )) {
    on<FetchInitialQueries>(_onFetchInitialQueriess);
    on<FetchMoreQueries>(_onFetchMoreQueries);
    on<SearchQueriess>(_onSearchQueries);
    on<AdminDeleteQueries>(_onAdminDeleteQueries);
    on<ReplyQuery>(_onReplyQuery);
  }

  Future<void> _onReplyQuery(
      ReplyQuery event, Emitter<QueriesState> emit) async {
    emit(state.copyWith(replyResponse: ApiResponse.loading()));
    try {
      final result = await _replyUsecase.call(event.parms);
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList =
            oldList?.where((r) => r.reqId != event.parms.id).toList();
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(List.from(optimisticList!)),
            replyResponse: ApiResponse.completed(result.data)));
      } else if (result is DataFailure<String>) {
        emit(state.copyWith(replyResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(replyResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onAdminDeleteQueries(
      AdminDeleteQueries event, Emitter<QueriesState> emit) async {
    emit(state.copyWith(deleteResponse: ApiResponse.loading()));
    try {
      final result = await _deleteUsecase.call(event.id.toString());
      if (result is DataSuccess<String>) {
        final oldList = state.fetchResponse.data;

        final optimisticList =
            oldList?.where((r) => r.reqId != event.id).toList();
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

  Future<void> _onFetchInitialQueriess(
      FetchInitialQueries event, Emitter<QueriesState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms =
          QueryParms(page: '1', search: state.query, type: event.type);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<QueriesEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<QueriesEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onSearchQueries(
      SearchQueriess event, Emitter<QueriesState> emit) async {
    emit(state.copyWith(fetchResponse: ApiResponse.loading()));

    try {
      final parms =
          QueryParms(page: '1', search: event.query, type: event.type);
      final result = await _useCase.call(parms);

      if (result is DataSuccess<QueriesEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<QueriesEntity>) {
        emit(state.copyWith(fetchResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(state.copyWith(fetchResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchMoreQueries(
      FetchMoreQueries event, Emitter<QueriesState> emit) async {
    if (state.pagination!.hasNext && !state.isLoadingMore) {
      emit(state.copyWith(isLoadingMore: true));

      try {
        final nextPage = state.pagination!.currentPage + 1;
        final parms = QueryParms(
            page: nextPage.toString(), search: state.query, type: event.type);
        final result = await _useCase.call(parms);

        if (result is DataSuccess<QueriesEntity>) {
          final newData = result.data;

          final updatedList =
              List<QueriesItem>.from(state.fetchResponse.data!)
                ..addAll(newData.data);

          emit(state.copyWith(
              fetchResponse: ApiResponse.completed(updatedList),
              pagination: newData.pagination,
              isLoadingMore: false));
        } else if (result is DataFailure<QueriesEntity>) {
          emit(state.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingMore: false));
      }
    }
  }
}
