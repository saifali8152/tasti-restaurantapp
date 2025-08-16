class RestaurantSeatingAreaEntity {
  final int id;
  final String seatingAreaName;
  final int restaurantId;
  final String abbreviation;

  RestaurantSeatingAreaEntity({
    required this.id,
    required this.seatingAreaName,
    required this.restaurantId,
    required this.abbreviation,
  });
}