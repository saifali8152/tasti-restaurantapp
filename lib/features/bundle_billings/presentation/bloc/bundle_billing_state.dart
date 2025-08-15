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
  final ApiResponse<ReataurantTransactionHistoryEntity>
      fetchTransactionHistoryResponse;

  const BundleBillingState({
    required this.fetchBundleResponse,
    required this.fetchSMSResponse,
    required this.fetchTransactionHistoryResponse,
    this.bundlePagination,
    this.isBundleLoadingMore = false,
  });

  BundleBillingState copyWith({
    ApiResponse<ReataurantTransactionHistoryEntity>?
        fetchTransactionHistoryResponse,
    final ApiResponse<List<SMSEntity>>? fetchSMSResponse,
    final ApiResponse<List<BundleItem>>? fetchBundleResponse,
    final PaginationModel? bundlePagination,
    final bool? isBundleLoadingMore,
  }) {
    return BundleBillingState(
      bundlePagination: bundlePagination ?? this.bundlePagination,
      isBundleLoadingMore: isBundleLoadingMore ?? this.isBundleLoadingMore,
      fetchBundleResponse: fetchBundleResponse ?? this.fetchBundleResponse,
      fetchSMSResponse: fetchSMSResponse ?? this.fetchSMSResponse,
      fetchTransactionHistoryResponse: fetchTransactionHistoryResponse ??
          this.fetchTransactionHistoryResponse,
    );
  }

  @override
  List<Object?> get props =>
      [fetchBundleResponse, fetchSMSResponse, fetchTransactionHistoryResponse, isBundleLoadingMore, bundlePagination];
}
