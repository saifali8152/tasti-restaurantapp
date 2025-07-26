enum SubscriptionStatus {
  active,
  noRestaurant,
  restaurantSuspended,
  inactive,
  expired,
}

extension SubscriptionExtension on SubscriptionStatus {
  String get title {
    switch (this) {
      case SubscriptionStatus.active:
        return "active";
      case SubscriptionStatus.noRestaurant:
        return "no_restaurant";
      case SubscriptionStatus.restaurantSuspended:
        return "restaurant_suspended";
      case SubscriptionStatus.inactive:
        return "inactive";
      case SubscriptionStatus.expired:
        return "expired";
    }
  }

  int get index {
    return this.index; 
  }
}