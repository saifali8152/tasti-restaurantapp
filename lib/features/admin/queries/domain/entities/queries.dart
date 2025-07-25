import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class QueriesEntity extends Equatable {
  final List<QueriesItem> data;
  final PaginationModel pagination;

  const QueriesEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class QueriesItem extends Equatable {
  final int reqId;
  final String name;
  final String email;
  final String phone;
  final String text;
  final String city;
  final String role;
  final String date;
  final String subject;
  final String type;
  final String names;
  final String action;
  final String dateFormatted;

  const QueriesItem({
    required this.reqId,
    required this.name,
    required this.email,
    required this.phone,
    required this.text,
    required this.city,
    required this.role,
    required this.date,
    required this.subject,
    required this.type,
    required this.names,
    required this.action,
    required this.dateFormatted,
  });
  
  @override
  List<Object?> get props => [
        reqId,
        name,
        email,
        phone,
        text,
        city,
        role,
        date,
        subject,
        type,
        names,
        action,
        dateFormatted,
      ];
}
