import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/models/pagination.dart';

class AdminSmsEntity extends Equatable {
  final List<AdminSmsItem> data;
  final PaginationModel pagination;

  const AdminSmsEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class AdminSmsItem extends Equatable {
  final int id;
  final String productOwner;
  final String discount;
  final String percentage;
  final String bundles;
  final String amount;
  final bool hasDiscount;

  const AdminSmsItem({
    required this.id,
    required this.productOwner,
    required this.discount,
    required this.percentage,
    required this.bundles,
    required this.amount,
    required this.hasDiscount,
  });

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
