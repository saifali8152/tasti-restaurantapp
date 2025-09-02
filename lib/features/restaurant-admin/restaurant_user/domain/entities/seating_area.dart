class SeatingAreaEntity {
  final int id;
  final String seatingAreaName;
  final String abbreviation;
  final String capacity;
  final List<TableEntity> tables;

  SeatingAreaEntity({
    required this.id,
    required this.seatingAreaName,
    required this.abbreviation,
    required this.capacity,
    required this.tables,
  });
}

class TableEntity {
  final int maxCapacity;
  final int minCapacity;
  final int tableMax;
  final String? abbreviation;
  final int isMoveable;
  final String type;
  final String shape;

  TableEntity({
    required this.maxCapacity,
    required this.minCapacity,
    required this.tableMax,
    this.abbreviation,
    required this.isMoveable,
    required this.type,
    required this.shape,
  });
}
