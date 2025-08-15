import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';
import '/core/network/response.dart';

class BundleBillingState extends Equatable {
  final ApiResponse<List<SMSEntity>> fetchSMSResponse;
  final ApiResponse<List<BundleItem>> fetchBundleResponse;
  final PaginationModel? bundlePagination;
  final bool isBundleLoadingMore;
  final ApiResponse<List<RestaurantTransactionHistoryItem>>
      fetchTransactionHistoryResponse;
  final PaginationModel? transactionPagination;
  final bool isTransactionLoadingMore;

  const BundleBillingState({
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
      isBundleLoadingMore: isBundleLoadingMore ?? this.isBundleLoadingMore,
      fetchBundleResponse: fetchBundleResponse ?? this.fetchBundleResponse,
      fetchSMSResponse: fetchSMSResponse ?? this.fetchSMSResponse,
      fetchTransactionHistoryResponse: fetchTransactionHistoryResponse ??
          this.fetchTransactionHistoryResponse,
    );
  }

  @override
  List<Object?> get props => [
        fetchBundleResponse,
        fetchSMSResponse,
        fetchTransactionHistoryResponse,
        isBundleLoadingMore,
        bundlePagination,
        transactionPagination,
        isTransactionLoadingMore,
      ];
}
