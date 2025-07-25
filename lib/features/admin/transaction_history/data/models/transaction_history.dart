import '/core/models/pagination.dart';
import '/features/admin/transaction_history/domain/entities/transaction_history.dart';

class TransactionHistoryModel extends TransactionHistoryEntity {
  const TransactionHistoryModel({
    required List<TransactionHistoryItemModel> super.data,
    required super.pagination,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      data: List<TransactionHistoryItemModel>.from(
        json['data'].map((item) => TransactionHistoryItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as TransactionHistoryItemModel).toJson()).toList(),
      'pagination': (pagination as TransactionHistoryItemModel).toJson(),
    };
  }
}

class TransactionHistoryItemModel extends TransactionHistoryItem {
  const TransactionHistoryItemModel({
    required super.id,
    required super.reference,
    required super.status,
    required super.transactionDate,
    required super.userId,
    required super.amount,
  });

  factory TransactionHistoryItemModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryItemModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      reference: json['reference'] ?? '',
      amount: json['amount'] ?? '',
      status: json['status'] ?? '',
      transactionDate: json['transaction_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'reference': reference,
      'status': status,
      'transaction_date': transactionDate,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        reference,
        status,
        amount,
        transactionDate,
      ];
}
