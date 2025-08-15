import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<FetchBundleBillingEvent>(_onFetchBundleBillingEvent);
    on<FetchSMSBundleBillingEvent>(_onFetchSMSBundleBillingEvent);
    on<FetchRestaurantTransactionHistoryBundleBillingEvent>(_onFetchRestaurantTransactionHistoryBundleBillingEvent);
  }

  Future<void> _onFetchBundleBillingEvent(
      FetchBundleBillingEvent event, Emitter<BundleBillingState> emit) async {
    emit(state.copyWith(fetchBundleResponse: ApiResponse.loading()));
    final result = await _fetchBundleUsecase(event.parms);

    switch (result) {
      case DataSuccess<BundleEntity>():
        emit(state.copyWith(fetchBundleResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchBundleResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchBundleResponse: ApiResponse.initial()));
    }
  }
  
  Future<void> _onFetchRestaurantTransactionHistoryBundleBillingEvent(
      FetchRestaurantTransactionHistoryBundleBillingEvent event, Emitter<BundleBillingState> emit) async {
    emit(state.copyWith(fetchTransactionHistoryResponse: ApiResponse.loading()));
    final result = await _fetchTransactionHistoryBundleUsecase(event.parms);

    switch (result) {
      case DataSuccess<ReataurantTransactionHistoryEntity>():
        emit(state.copyWith(fetchTransactionHistoryResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchTransactionHistoryResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchTransactionHistoryResponse: ApiResponse.initial()));
    }
  }
  
  Future<void> _onFetchSMSBundleBillingEvent(
      FetchSMSBundleBillingEvent event, Emitter<BundleBillingState> emit) async {
    emit(state.copyWith(fetchSMSResponse: ApiResponse.loading()));
    final result = await _fetchSMSUsecase(null);

    switch (result) {
      case DataSuccess<List<SMSEntity>>():
        emit(state.copyWith(fetchSMSResponse: ApiResponse.completed(result.data)));
        break;
      case DataFailure():
        emit(state.copyWith(fetchSMSResponse: ApiResponse.error(result.error)));
        break;
      default:
        emit(state.copyWith(fetchSMSResponse: ApiResponse.initial()));
    }
  }
}
