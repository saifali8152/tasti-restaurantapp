import 'package:equatable/equatable.dart';
import '/core/models/pagination.dart';

class RequestEntity extends Equatable {
  final List<RequestItem> data;
  final PaginationModel pagination;

  const RequestEntity({
    required this.data,
    required this.pagination,
  });

  @override
  List<Object?> get props => [data, pagination];
}

class RequestItem extends Equatable {
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

  const RequestItem({
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
