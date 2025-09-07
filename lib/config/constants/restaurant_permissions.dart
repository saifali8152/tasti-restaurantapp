import 'package:tasti_restaurant_app/core/parms/parms.dart';

// Updated permission lists to match the hierarchical structure
final List<PermissionData> restaurantUserPermissions = [
  PermissionData(key: "stats", title: "Stats"),
  PermissionData(key: "reservations", title: "Reservations"),
  PermissionData(key: "availability", title: "Availability"), // This encompasses all availability sub-items
  PermissionData(key: "reservationDatabase", title: "Reservation Database"),
  PermissionData(key: "maintainReviews", title: "Maintain Reviews"),
  PermissionData(key: "bundleAndBillings", title: "Bundles and Billings"),
  PermissionData(key: "restaurantSettings", title: "Restaurant Settings"),
  PermissionData(key: "shareWidget", title: "Share Widget"),
];

final List<PermissionData> adminUserPermissions = [
  PermissionData(key: "stats", title: "Stats"),
  PermissionData(key: "restaurants", title: "Restaurants"),
  PermissionData(key: "maintainMore", title: "Maintain more"), // This encompasses all maintain sub-items
  PermissionData(key: "events", title: "Events"),
  PermissionData(key: "manageSmsFee", title: "Manage SMS & Fees"),
  PermissionData(key: "campaigns", title: "Campaigns"),
];

// Additional granular permissions if you need individual control later
final List<PermissionData> granularAdminPermissions = [
  PermissionData(key: "stats", title: "Stats"),
  PermissionData(key: "restaurants", title: "Restaurants"),
  
  // Maintain More sub-permissions
  PermissionData(key: "todayRequests", title: "Today's Requests"),
  PermissionData(key: "todayQueries", title: "Today's Queries"),
  PermissionData(key: "monthlyRequests", title: "Monthly Requests"),
  PermissionData(key: "monthlyQueries", title: "Monthly Queries"),
  PermissionData(key: "overallRequests", title: "Overall Requests"),
  PermissionData(key: "overallQueries", title: "Overall Queries"),
  PermissionData(key: "reservationsDatabase", title: "Reservations Database"),
  
  PermissionData(key: "events", title: "Events"),
  PermissionData(key: "manageSmsFee", title: "Manage SMS & Fees"),
  PermissionData(key: "campaigns", title: "Campaigns"),
];

final List<PermissionData> granularRestaurantPermissions = [
  PermissionData(key: "stats", title: "Stats"),
  PermissionData(key: "reservations", title: "Reservations"),
  
  // Availability sub-permissions
  PermissionData(key: "bookingTime", title: "Manage Booking Time"),
  PermissionData(key: "workingHours", title: "Working Hours"),
  PermissionData(key: "seatingArea", title: "Seating Area"),
  PermissionData(key: "cuisines", title: "Add Cuisines & More"),
  PermissionData(key: "foodMenu", title: "Food Menu"),
  PermissionData(key: "gallery", title: "Gallery"),
  
  PermissionData(key: "reservationDatabase", title: "Reservation Database"),
  PermissionData(key: "maintainReviews", title: "Maintain Reviews"),
  PermissionData(key: "bundleAndBillings", title: "Bundles and Billings"),
  PermissionData(key: "restaurantSettings", title: "Restaurant Settings"),
  PermissionData(key: "shareWidget", title: "Share Widget"),
];