import 'package:tasti_restaurant_app/core/parms/parms.dart';

final List<PermissionData> restaurantUserPermissions = [
  PermissionData(key: "stats", title: "Stats"),
  PermissionData(key: "reservations", title: "Reservations"),
  PermissionData(key: "availability", title: "Availability"),
  PermissionData(key: "reservationDatabase", title: "Reservation Database"),
  PermissionData(key: "maintainReviews", title: "Maintain Reviews"),
  PermissionData(key: "bundleAndBillings", title: "Bundles and Billings"),
  PermissionData(key: "restaurantSettings", title: "Restaurant Settings"),
  PermissionData(key: "shareWidget", title: "Share Widget"),
];

final List<PermissionData> adminUserPermissions = [
  PermissionData(key: "stats", title: "Stats"),
  PermissionData(key: "restaurants", title: "Restaurants"),
  PermissionData(key: "maintainMore", title: "Maintain more"),
  PermissionData(key: "events", title: "Events"),
  PermissionData(key: "manageSmsFee", title: "Manage SMS & Fees"),
  PermissionData(key: "campaigns", title: "Campaigns"),
];
