import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/usecases/add_sms_bundle.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/entities/today_requests.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/usecases/delete_today_requests.dart';
import 'package:tasti_restaurant_app/features/admin/today_requests/domain/usecases/fetch_today_requests.dart';
import '/core/network/response.dart';
import 'today_request_event.dart';
import 'today_request_state.dart';

class TodayRequestBloc extends Bloc<TodayRequestEvents, TodayRequestState> {
  final FetchTodayRequestUsecase _useCase;
  final DeleteTodayRequestUsecase _deleteUsecase;

  final AddSMSBundleUsecase _addUsecase;


  TodayRequestBloc(this._useCase, this._deleteUsecase, this._addUsecase)
      : super(TodayRequestState(
            fetchResponse: ApiResponse.initial(),
            deleteResponse: ApiResponse.initial(),
            addResponse: ApiResponse.initial())) {
    on<FetchInitialTodayRequests>(_onFetchInitialTodayRequests);
    on<FetchMoreTodayRequests>(_onFetchMoreTodayRequests);
    on<SearchTodayRequests>(_onSearchTodayRequests);
    on<AdminDeleteTodayRequest>(_onAdminDeleteTodayRequest);
    // on<AdminAddSmsRequested>(_onAdminAddSmsRequested);
  }

  // Future<void> _onAdminAddSmsRequested(
  //   AdminAddSmsRequested event, Emitter<TodayRequestState> emit) async {
  // emit(state.copyWith(addResponse: ApiResponse.loading()));

  // final params = AddSMSBundleParms(
  //   owner: event.parms.owner,
  //   quantity: event.parms.quantity,
  //   discount: event.parms.discount,
  //   price: event.parms.price,
  //   percentage: event.parms.percentage,
  // );

  // final result = await _addUsecase(params);

  // if (result is DataSuccess<String>) {
    /*
    final newSmsItem = AdminSmsItem(
      id: GENERATED_ID_OR_NULL,
      owner: event.parms.owner,
      quantity: event.parms.quantity,
      discount: event.parms.discount,
      price: event.parms.price,
      percentage: event.parms.percentage,
    );

    final updatedList = List<AdminSmsItem>.from(state.fetchResponse.data ?? [])
      ..insert(0, newSmsItem); // Add to top

    emit(state.copyWith(
      fetchResponse: ApiResponse.completed(updatedList),
      addResponse: ApiResponse.completed(result.data),
    ));
    */

    // Since your API returns only a String (probably success message),
    // safest option is to refresh the list to sync with backend:

//     final fetchParams = PaginationParms(page: '1', search: '');
//     final fetchResult = await _useCase.call(fetchParams);

//     if (fetchResult is DataSuccess<AdminSmsEntity>) {
//       emit(state.copyWith(
//         fetchResponse: ApiResponse.completed(fetchResult.data.data),
//         pagination: fetchResult.data.pagination,
//         addResponse: ApiResponse.completed(result.data),
//       ));
//     } else if (fetchResult is DataFailure<AdminSmsEntity>) {
//       emit(state.copyWith(
//         addResponse: ApiResponse.completed(result.data), // still success for add
//         fetchResponse: ApiResponse.error(fetchResult.error),
//       ));
//     }

//   } else if (result is DataFailure<String>) {
//     emit(state.copyWith(addResponse: ApiResponse.error(result.error)));
//   }
// }


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
      final parms = PaginationParms(
        page: '1',
        search: state.query,
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<TodayRequestEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<TodayRequestEntity>) {
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
      final parms = PaginationParms(
        page: '1',
        search: event.query,
      );
      final result = await _useCase.call(parms);

      if (result is DataSuccess<TodayRequestEntity>) {
        emit(state.copyWith(
            fetchResponse: ApiResponse.completed(result.data.data),
            pagination: result.data.pagination));
      } else if (result is DataFailure<TodayRequestEntity>) {
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
        final parms = PaginationParms(
          page: nextPage.toString(),
          search: state.query,
        );
        final result = await _useCase.call(parms);

        if (result is DataSuccess<TodayRequestEntity>) {
          final newData = result.data;

          final updatedList = List<TodayRequestItem>.from(state.fetchResponse.data!)
            ..addAll(newData.data);

          emit(state.copyWith(
              fetchResponse: ApiResponse.completed(updatedList),
              pagination: newData.pagination,
              isLoadingMore: false));
        } else if (result is DataFailure<TodayRequestEntity>) {
          emit(state.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isLoadingMore: false));
      }
    }
  }
}
