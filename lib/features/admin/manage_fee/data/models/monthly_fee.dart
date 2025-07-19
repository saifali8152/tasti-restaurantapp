import 'package:tasti_restaurant_app/features/admin/manage_fee/domain/entities/monthly_fee.dart';

class MonthlyFeeModel extends MonthlyFeeEntity {
  const MonthlyFeeModel({
    required super.id,
    required super.money,
  });

  factory MonthlyFeeModel.fromJson(Map<String, dynamic> json) {
    return MonthlyFeeModel(
      id: json['id'] ?? 0,
      money: json['money'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'money': money};
  }

  @override
  List<Object?> get props => [id, money];
}
