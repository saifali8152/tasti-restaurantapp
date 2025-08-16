// Entity
class RestaurantTimeSlotEntity {
  final int restaurantId;
  final String date;
  final List<String> availableTimeSlots;

  RestaurantTimeSlotEntity({
    required this.restaurantId,
    required this.date,
    required this.availableTimeSlots,
  });
}