import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';
abstract class BundleBillingEvent extends Equatable {
  const BundleBillingEvent();

  @override
  List<Object?> get props => [];
}
class InitSmsPayment extends BundleBillingEvent {
  final int bundleId;

  const InitSmsPayment(this.bundleId);
}

class VerifySmsPayment extends BundleBillingEvent {
  final VerifySmsPaymentParms parms;

  const VerifySmsPayment(this.parms);
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