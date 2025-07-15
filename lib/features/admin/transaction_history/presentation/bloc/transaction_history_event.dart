import 'package:equatable/equatable.dart';

abstract class FetchTransactionHistoryEvent extends Equatable {
  const FetchTransactionHistoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchInitialTransactionHistory extends FetchTransactionHistoryEvent {}

class FetchMoreTransactionHistory extends FetchTransactionHistoryEvent {}
