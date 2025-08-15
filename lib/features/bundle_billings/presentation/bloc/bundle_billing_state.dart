import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/init_payment.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';
import '/core/network/response.dart';

class BundleBillingState extends Equatable {
  final ApiResponse<InitPaymentEntity> initPaymentResponse;
  final ApiResponse<String> verifyPaymentResponse;
  final ApiResponse<List<SMSEntity>> fetchSMSResponse;
  final ApiResponse<List<BundleItem>> fetchBundleResponse;
  final PaginationModel? bundlePagination;
  final bool isBundleLoadingMore;
  final ApiResponse<List<RestaurantTransactionHistoryItem>>
      fetchTransactionHistoryResponse;
  final PaginationModel? transactionPagination;
  final bool isTransactionLoadingMore;

  const BundleBillingState({
    required this.initPaymentResponse,
    required this.verifyPaymentResponse,
    required this.fetchBundleResponse,
    required this.fetchSMSResponse,
    required this.fetchTransactionHistoryResponse,
    this.bundlePagination,
    this.transactionPagination,
    this.isBundleLoadingMore = false,
    this.isTransactionLoadingMore = false,
  });

  BundleBillingState copyWith({
    ApiResponse<List<RestaurantTransactionHistoryItem>>?
        fetchTransactionHistoryResponse,
    final ApiResponse<List<SMSEntity>>? fetchSMSResponse,
    final ApiResponse<List<BundleItem>>? fetchBundleResponse,
    final ApiResponse<String>? verifyPaymentResponse,
    final ApiResponse<InitPaymentEntity>? initPaymentResponse,
    final PaginationModel? bundlePagination,
    final PaginationModel? transactionPagination,
    final bool? isBundleLoadingMore,
    final bool? isTransactionLoadingMore,
  }) {
    return BundleBillingState(
      transactionPagination:
          transactionPagination ?? this.transactionPagination,
      isTransactionLoadingMore:
          isTransactionLoadingMore ?? this.isTransactionLoadingMore,
      bundlePagination: bundlePagination ?? this.bundlePagination,
      verifyPaymentResponse: verifyPaymentResponse ?? ApiResponse.initial(),
      isBundleLoadingMore: isBundleLoadingMore ?? this.isBundleLoadingMore,
      fetchBundleResponse: fetchBundleResponse ?? this.fetchBundleResponse,
      initPaymentResponse: initPaymentResponse ?? ApiResponse.initial(),
      fetchSMSResponse: fetchSMSResponse ?? this.fetchSMSResponse,
      fetchTransactionHistoryResponse: fetchTransactionHistoryResponse ??
          this.fetchTransactionHistoryResponse,
    );
  }

  @override
  List<Object?> get props => [
        initPaymentResponse,
        verifyPaymentResponse,
        fetchBundleResponse,
        fetchSMSResponse,
        fetchTransactionHistoryResponse,
        isBundleLoadingMore,
        bundlePagination,
        transactionPagination,
        isTransactionLoadingMore,
      ];
}
