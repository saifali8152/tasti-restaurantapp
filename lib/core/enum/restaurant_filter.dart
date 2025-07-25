enum RestaurantFilter {
  all,
  paid,
  notPaid,
  suspended,
}

extension ReataurantFilterExtension on RestaurantFilter {
  String get title {
    switch (this) {
      case RestaurantFilter.all:
        return "All";
      case RestaurantFilter.paid:
        return "Paid";
      case RestaurantFilter.notPaid:
        return "Not Paid";
      case RestaurantFilter.suspended:
        return "Suspended";
    }
  }

  int get index {
    return this.index; 
  }
}

extension ReataurantFilterValueExtension on RestaurantFilter {
  String get value {
    switch (this) {
      case RestaurantFilter.all:
        return "";
      case RestaurantFilter.paid:
        return "paid";
      case RestaurantFilter.notPaid:
        return "not";
      case RestaurantFilter.suspended:
        return "suspended";
    }
  }

  int get index {
    return this.index; 
  }
}
