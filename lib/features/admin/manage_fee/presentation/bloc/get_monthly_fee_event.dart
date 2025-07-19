import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

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

