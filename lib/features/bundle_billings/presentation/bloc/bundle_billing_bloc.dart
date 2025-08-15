import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/usecases/fetch_bundles.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/usecases/fetch_sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/usecases/fetch_transaction_histroy.dart';
import '/core/network/response.dart';
import 'bundle_billing_event.dart';
import 'bundle_billing_state.dart';

class BundleBillingBloc extends Bloc<BundleBillingEvent, BundleBillingState> {
  final FetchSmsUsecase _fetchSMSUsecase;
  final FetchBundlesUsecase _fetchBundleUsecase;
  final FetchTransactionHistroyUsecase _fetchTransactionHistoryBundleUsecase;

  BundleBillingBloc(
    this._fetchBundleUsecase,
    this._fetchSMSUsecase,
    this._fetchTransactionHistoryBundleUsecase,
  ) : super(BundleBillingState(
          fetchBundleResponse: ApiResponse.initial(),
          fetchSMSResponse: ApiResponse.initial(),
          fetchTransactionHistoryResponse: ApiResponse.initial(),
        )) {
    on<FetchInitialBundleBillingEvent>(_onFetchInitialBundleBillingEvent);
    on<FetchMoreBundleBillingEvent>(_onFetchMoreBundleBillingEvent);
    on<FetchSMSBundleBillingEvent>(_onFetchSMSBundleBillingEvent);
    on<FetchRestaurantTransactionHistoryBundleBillingEvent>(
        _onFetchRestaurantTransactionHistoryBundleBillingEvent);
  }

  Future<void> _onFetchMoreBundleBillingEvent(FetchMoreBundleBillingEvent event,
      Emitter<BundleBillingState> emit) async {
    if (state.bundlePagination!.hasNext && !state.isBundleLoadingMore) {
      emit(state.copyWith(isBundleLoadingMore: true));

      try {
        final nextPage = state.bundlePagination!.currentPage + 1;
        final parms =
            PaginationParms(page: nextPage.toString(), id: event.id.toString());
        final result = await _fetchBundleUsecase.call(parms);

        if (result is DataSuccess<BundleEntity>) {
          final newData = result.data;

          final updatedList = List<BundleItem>.from(state.fetchBundleResponse.data!)
            ..addAll(newData.data);

          emit(state.copyWith(
              fetchBundleResponse: ApiResponse.completed(updatedList),
              bundlePagination: newData.pagination,
              isBundleLoadingMore: false));
        } else if (result is DataFailure<BundleEntity>) {
          emit(state.copyWith(isBundleLoadingMore: false));
        }
      } catch (e) {
        emit(state.copyWith(isBundleLoadingMore: false));
      }
    }
  }

  Future<void> _onFetchInitialBundleBillingEvent(
      FetchInitialBundleBillingEvent event,
      Emitter<BundleBillingState> emit) async {
    emit(state.copyWith(fetchBundleResponse: ApiResponse.loading()));

    emit(state.copyWith(fetchBundleResponse: ApiResponse.loading()));

    try {
      final parms = PaginationParms(page: '1', id: event.id.toString());
      final result = await _fetchBundleUsecase(parms);

      if (result is DataSuccess<BundleEntity>) {
        emit(
          state.copyWith(
            fetchBundleResponse: ApiResponse.completed(result.data.data),
            bundlePagination: result.data.pagination,
          ),
        );
      } else if (result is DataFailure<BundleEntity>) {
        emit(state.copyWith(
            fetchBundleResponse: ApiResponse.error(result.error)));
      }
    } catch (e) {
      emit(
          state.copyWith(fetchBundleResponse: ApiResponse.error(e.toString())));
    }
  }

  Future<void> _onFetchRestaurantTransactionHistoryBundleBillingEvent(
      FetchRestaurantTransactionHistoryBundleBillingEvent event,
      Emitter<BundleBillingState> emit) async {
    emit(
        state.copyWith(fetchTransactionHistoryResponse: ApiResponse.loading()));
    final result = await _fetchTransactionHistoryBundleUsecase(event.parms);

    switch (result) {
      case DataSuccess<ReataurantTransactionHistoryEntity>():
        emit(state.copyWith(
            fetchTransactionHistoryResponse:
                ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(
            fetchTransactionHistoryResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(
            fetchTransactionHistoryResponse: ApiResponse.initial()));
    }
  }

  Future<void> _onFetchSMSBundleBillingEvent(FetchSMSBundleBillingEvent event,
      Emitter<BundleBillingState> emit) async {
    emit(state.copyWith(fetchSMSResponse: ApiResponse.loading()));
    final result = await _fetchSMSUsecase(null);

    switch (result) {
      case DataSuccess<List<SMSEntity>>():
        emit(state.copyWith(
            fetchSMSResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchSMSResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchSMSResponse: ApiResponse.initial()));
    }
  }
}
