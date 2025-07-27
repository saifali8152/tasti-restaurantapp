import 'package:equatable/equatable.dart';
import '/core/parms/parms.dart';

abstract class MonthlyFeeEvents extends Equatable {
  const MonthlyFeeEvents();

  @override
  List<Object?> get props => [];
}

class UpdateMonthlyFeeSubmitted extends MonthlyFeeEvents {
  final UpdateMonthlyFeeParms parms;
  const UpdateMonthlyFeeSubmitted(this.parms);
}

class FetchMonthlyFeeSubmitted extends MonthlyFeeEvents {}
class VerifyPaymentSubmitted extends MonthlyFeeEvents {
  final String reference;

  const VerifyPaymentSubmitted(this.reference);
}
class InitPaymentSubmitted extends MonthlyFeeEvents {
  final String amount;

  const InitPaymentSubmitted(this.amount);
}

