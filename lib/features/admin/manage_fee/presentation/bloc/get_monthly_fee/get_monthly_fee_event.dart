import 'package:equatable/equatable.dart';
import 'package:tasti_restaurant_app/core/parms/parms.dart';

abstract class MonthlyFeeEvents extends Equatable {
  const MonthlyFeeEvents();

  @override
  List<Object?> get props => [];
}

class AdminAddSmsRequested extends MonthlyFeeEvents {
  final AddSMSBundleParms parms;
  const AdminAddSmsRequested(this.parms);
}

class FetchMonthlyFeeSubmitted extends MonthlyFeeEvents {}

