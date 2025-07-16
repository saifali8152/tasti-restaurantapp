import '/core/network/response.dart';

class ManageSmsBundleDiscountState {
  final ApiResponse manageDiscountResponse;
  final int discount;
  final int price;
  final int percentage;

  const ManageSmsBundleDiscountState({
    required this.manageDiscountResponse,
    this.discount = 0,
    this.price = 0,
    this.percentage = 0,
  });

  ManageSmsBundleDiscountState copyWith({
    final ApiResponse? manageDiscountResponse,
    final int? discount,
    final int? price,
    final int? percentage,
  }) {
    return ManageSmsBundleDiscountState(
      manageDiscountResponse: manageDiscountResponse ?? ApiResponse.initial(),
      discount: discount ?? this.discount,
      price: price ?? this.price,
      percentage: percentage ?? this.percentage,
    );
  }
}
