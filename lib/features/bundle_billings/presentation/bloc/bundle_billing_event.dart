import 'package:equatable/equatable.dart';
abstract class BundleBillingEvent extends Equatable {
  const BundleBillingEvent();

  @override
  List<Object?> get props => [];
}
class FetchInitialBundleBillingEvent extends BundleBillingEvent {
  final int id;

  const FetchInitialBundleBillingEvent(this.id);
}
class FetchMoreBundleBillingEvent extends BundleBillingEvent {
  final int id;

  const FetchMoreBundleBillingEvent(this.id);
}

class FetchSMSBundleBillingEvent extends BundleBillingEvent {}

class FetchInitialRestaurantTransactions extends BundleBillingEvent {}
class FetchMoreRestaurantTransactions extends BundleBillingEvent {}