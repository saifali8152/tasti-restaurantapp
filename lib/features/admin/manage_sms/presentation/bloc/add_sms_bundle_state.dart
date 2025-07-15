import '/core/network/response.dart';

class AddSmsBundleState {
  final ApiResponse addResposne;
  final String owner;
  final int quantity;
  final int discount;
  final int price;
  final int percentage;

  const AddSmsBundleState({
    required this.addResposne,
    this.owner = '',
    this.quantity = 0,
    this.discount = 0,
    this.price = 0,
    this.percentage = 0,
  });

  AddSmsBundleState copyWith({
    final ApiResponse? addResposne,
    final String? owner,
    final int? quantity,
    final int? discount,
    final int? price,
    final int? percentage,
  }) {
    return AddSmsBundleState(
      addResposne: addResposne ?? ApiResponse.initial(),
      owner: owner ?? this.owner,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      price: price ?? this.price,
      percentage: percentage ?? this.percentage,
    );
  }
}
