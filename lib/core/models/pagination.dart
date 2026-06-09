import 'package:equatable/equatable.dart';
import '/core/utils/json_parsers.dart';

class PaginationModel extends Equatable {
  final int currentPage;
  final int perPage;
  final int total;
  final int totalPages;
  final bool hasNext;
  final bool hasPrev;

  const PaginationModel({
    required this.currentPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: parseJsonInt(json['current_page'], 1),
      perPage: parseJsonInt(json['per_page'], 10),
      total: parseJsonInt(json['total']),
      totalPages: parseJsonInt(json['total_pages']),
      hasNext: parseJsonBool(json['has_next']),
      hasPrev: parseJsonBool(json['has_prev']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'has_next': hasNext,
      'has_prev': hasPrev,
    };
  }

  @override
  List<Object?> get props => [
        currentPage,
        perPage,
        total,
        totalPages,
        hasNext,
        hasPrev,
      ];
}
