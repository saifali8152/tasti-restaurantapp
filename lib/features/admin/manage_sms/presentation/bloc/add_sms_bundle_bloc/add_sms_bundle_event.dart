import 'package:equatable/equatable.dart';

abstract class AddSmsBundleEvent extends Equatable {
  const AddSmsBundleEvent();

  @override
  List<Object?> get props => [];
}

/// Event to set owner
class SetOwnerEvent extends AddSmsBundleEvent {
  final String owner;

  const SetOwnerEvent(this.owner);

  @override
  List<Object?> get props => [owner];
}

/// Event to set quantity
class SetQuantityEvent extends AddSmsBundleEvent {
  final int quantity;

  const SetQuantityEvent(this.quantity);

  @override
  List<Object?> get props => [quantity];
}

/// Event to set discount
class SetDiscountEvent extends AddSmsBundleEvent {
  final int discount;

  const SetDiscountEvent(this.discount);

  @override
  List<Object?> get props => [discount];
}

/// Event to set price
class SetPriceEvent extends AddSmsBundleEvent {
  final int price;

  const SetPriceEvent(this.price);

  @override
  List<Object?> get props => [price];
}

/// Event to set percentage
class SetPercentageEvent extends AddSmsBundleEvent {
  final int percentage;

  const SetPercentageEvent(this.percentage);

  @override
  List<Object?> get props => [percentage];
}

/// Event to submit the SMS bundle addition
class SubmitSmsBundleEvent extends AddSmsBundleEvent {
  const SubmitSmsBundleEvent();
}
