import 'package:equatable/equatable.dart';

abstract class ManageSmsBundleDiscountEvents extends Equatable {
  const ManageSmsBundleDiscountEvents();

  @override
  List<Object?> get props => [];
}

class SetPriceEvent extends ManageSmsBundleDiscountEvents {
  final int price;

  const SetPriceEvent(this.price);

  @override
  List<Object?> get props => [price];
}

class SetPercentageEvent extends ManageSmsBundleDiscountEvents {
  final int percentage;

  const SetPercentageEvent(this.percentage);

  @override
  List<Object?> get props => [percentage];
}

class SubmitManageSmsBundleDiscountEvent extends ManageSmsBundleDiscountEvents {
  final int id;
  const SubmitManageSmsBundleDiscountEvent(this.id);
}
