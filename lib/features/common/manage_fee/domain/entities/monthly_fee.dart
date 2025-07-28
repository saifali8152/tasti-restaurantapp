import 'package:equatable/equatable.dart';

class MonthlyFeeEntity extends Equatable {
  final int id;
  final String money;

  const MonthlyFeeEntity({
    required this.id,
    required this.money,
  });

  @override
  List<Object?> get props => [id, money];
}
