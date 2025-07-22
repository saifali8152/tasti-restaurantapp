import 'package:tasti_restaurant_app/core/models/pagination.dart';
import 'package:tasti_restaurant_app/features/admin/requests/domain/entities/requests.dart';

class RequestModel extends RequestEntity {
  const RequestModel({
    required super.data,
    required super.pagination,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      data: List<RequestItemModel>.from(
        json['data'].map((item) => RequestItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as RequestItemModel).toJson()).toList(),
      'pagination': (pagination as RequestItemModel).toJson(),
    };
  }
}

class RequestItemModel extends RequestItem {
  const RequestItemModel({
    required super.reqId,
    required super.name,
    required super.email,
    required super.phone,
    required super.text,
    required super.city,
    required super.role,
    required super.date,
    required super.subject,
    required super.type,
    required super.names,
    required super.action,
    required super.dateFormatted,
  });

  factory RequestItemModel.fromJson(Map<String, dynamic> json) {
    return RequestItemModel(
      reqId: json['req_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      text: json['text'] ?? 'N/A',
      city: json['city'] ?? '',
      role: json['role'] ?? '',
      date: json['date'] ?? '',
      subject: json['subject'] ?? '',
      type: json['type'] ?? '',
      names: json['names'] ?? '',
      action: json['action'] ?? '',
      dateFormatted: json['date_formatted'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'req_id': reqId,
      'name': name,
      'email': email,
      'phone': phone,
      'text': text,
      'city': city,
      'role': role,
      'date': date,
      'subject': subject,
      'type': type,
      'names': names,
      'action': action,
      'date_formatted': dateFormatted,
    };
  }

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
