import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/bundle.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/sms.dart';
import 'package:tasti_restaurant_app/features/bundle_billings/domain/entities/transaction_history.dart';
import '/core/network/response.dart';

class BundleBillingState extends Equatable {
  final ApiResponse<List<SMSEntity>> fetchSMSResponse;
  final ApiResponse<BundleEntity> fetchBundleResponse;
  final ApiResponse<ReataurantTransactionHistoryEntity> fetchTransactionHistoryResponse;

  const BundleBillingState({
    required this.fetchBundleResponse,
    required this.fetchSMSResponse,
    required this.fetchTransactionHistoryResponse,
  });

  BundleBillingState copyWith({
    ApiResponse<ReataurantTransactionHistoryEntity>? fetchTransactionHistoryResponse,
    final ApiResponse<List<SMSEntity>>? fetchSMSResponse,
  final ApiResponse<BundleEntity>? fetchBundleResponse,
  }) {
    return BundleBillingState(
      fetchBundleResponse: fetchBundleResponse ?? this.fetchBundleResponse,
      fetchSMSResponse: fetchSMSResponse ?? this.fetchSMSResponse,
      fetchTransactionHistoryResponse: fetchTransactionHistoryResponse ?? this.fetchTransactionHistoryResponse,
    );
  }

  @override
  List<Object?> get props => [fetchBundleResponse, fetchSMSResponse, fetchTransactionHistoryResponse];
}
