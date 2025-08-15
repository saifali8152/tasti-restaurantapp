import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

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

class FetchRestaurantTransactionHistoryBundleBillingEvent extends BundleBillingEvent {
  final PaginationParms parms;

  const FetchRestaurantTransactionHistoryBundleBillingEvent(this.parms);
}