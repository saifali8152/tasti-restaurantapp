import '/features/restaurant-admin/seating_area/domain/entities/seating_area.dart';

int _parseJsonBoolAsInt(dynamic value, [int fallback = 0]) {
  if (value == null) return fallback;
  if (value is bool) return value ? 1 : 0;
  if (value is int) return value;
  return int.tryParse(value.toString()) ?? fallback;
}

class SeatingAreaModel extends SeatingAreaEntity {
  SeatingAreaModel({
    required super.id,
    required super.seatingAreaName,
    required super.abbreviation,
    required super.capacity,
    required super.tables,
  });

  factory SeatingAreaModel.fromJson(Map<String, dynamic> json) {
    return SeatingAreaModel(
      id: json['id'] ?? 0,
      seatingAreaName: json['seating_area_name'] ?? '',
      abbreviation: json['abbreviation'] ?? '',
      capacity: json['capacity'].toString(),
      tables: (json['tables'] as List<dynamic>? ?? [])
          .map((table) => TableModel.fromJson(table))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seating_area_name': seatingAreaName,
      'abbreviation': abbreviation,
      'capacity': capacity,
      'tables': tables.map((table) {
        if (table is TableModel) {
          return table.toJson();
        }
        return {};
      }).toList(),
    };
  }
}

class TableModel extends TableEntity {
  TableModel({
    required super.maxCapacity,
    required super.minCapacity,
    required super.tableMax,
    super.abbreviation,
    required super.isMoveable,
    required super.type,
    required super.shape,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      maxCapacity: json['max_capacity'] ?? 0,
      minCapacity: json['min_capacity'] ?? 0,
      tableMax: json['table_max'] ?? 0,
      abbreviation: json['abbreviation'],
      isMoveable: _parseJsonBoolAsInt(json['is_moveable']),
      type: json['type'] ?? '',
      shape: json['shape'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_capacity': maxCapacity,
      'min_capacity': minCapacity,
      'table_max': tableMax,
      'abbreviation': abbreviation,
      'is_moveable': isMoveable,
      'type': type,
      'shape': shape,
    };
  }
}
