import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/admin/manage_sms/domain/entities/admin_sms.dart';

class AdminSmsModel extends AdminSmsEntity {
  const AdminSmsModel({
    required List<AdminsmsItemModel> super.data,
    required super.pagination,
  });

  factory AdminSmsModel.fromJson(Map<String, dynamic> json) {
    return AdminSmsModel(
      data: List<AdminsmsItemModel>.from(
        json['data'].map((item) => AdminsmsItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as AdminsmsItemModel).toJson()).toList(),
      'pagination': (pagination as AdminsmsItemModel).toJson(),
    };
  }
}

class AdminsmsItemModel extends AdminSmsItem {
  const AdminsmsItemModel({
    required super.id,
    required super.productOwner,
    required super.discount,
    required super.percentage,
    required super.bundles,
    required super.amount,
    required super.hasDiscount,
  });

  factory AdminsmsItemModel.fromJson(Map<String, dynamic> json) {
    return AdminsmsItemModel(
      id: json['id'] ?? 0,
      productOwner: json['product_owner'] ?? '',
      discount: json['discount'] ?? '',
      percentage: json['percentage'] ?? '',
      bundles: json['bundles'] ?? '',
      amount: json['amount'] ?? '',
      hasDiscount: json['has_discount'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_owner': productOwner,
      'discount': discount,
      'percentage': percentage,
      'bundles': bundles,
      'amount': amount,
      'has_discount': hasDiscount,
    };
  }

  @override
  List<Object?> get props => [
        id,
        productOwner,
        discount,
        percentage,
        bundles,
        amount,
        hasDiscount,
      ];
}
