import '/core/models/pagination.dart';
import '/features/admin/queries/domain/entities/queries.dart';

class QueriesModel extends QueriesEntity {
  const QueriesModel({
    required super.data,
    required super.pagination,
  });

  factory QueriesModel.fromJson(Map<String, dynamic> json) {
    return QueriesModel(
      data: List<QueriesItemModel>.from(
        json['data'].map((item) => QueriesItemModel.fromJson(item)),
      ),
      pagination: PaginationModel.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => (e as QueriesItemModel).toJson()).toList(),
      'pagination': (pagination as QueriesItemModel).toJson(),
    };
  }
}

class QueriesItemModel extends QueriesItem {
  const QueriesItemModel({
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

  factory QueriesItemModel.fromJson(Map<String, dynamic> json) {
    return QueriesItemModel(
      reqId: json['req_id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      text: json['text'] ?? '',
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
}
