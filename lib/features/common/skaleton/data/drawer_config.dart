import 'package:flutter/material.dart';
import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/common/skaleton/data/drawer_item_model.dart';

class DrawerConfig {
  // Updated permission keys to match API response
  static const String adminStatsPermission = 'stats';
  static const String restaurantsPermission = 'restaurants';
  static const String maintainMorePermission = 'maintainMore';
  static const String eventsPermission = 'events';
  static const String smsManagementPermission = 'manageSmsFee';
  static const String campaignsPermission = 'campaigns';
  static const String profilePermission = 'profile';
  
  // Restaurant permission keys
  static const String restaurantStatsPermission = 'stats';
  static const String reservationsPermission = 'reservations';
  static const String availabilityPermission = 'availability';
  static const String reservationDatabasePermission = 'reservationDatabase';
  static const String maintainReviewsPermission = 'maintainReviews';
  static const String bundleBillingsPermission = 'bundleAndBillings';
  static const String restaurantSettingsPermission = 'restaurantSettings';
  static const String shareWidgetPermission = 'shareWidget';

  static List<DrawerItemModel> drawerItemsForRole(
    String role, {
    bool shouldCheckPermissions = false,
    List<PermissionEntity>? userPermissions,
  }) {
    final permissionKeys = shouldCheckPermissions && userPermissions != null
        ? userPermissions.map((p) => p.key).toSet()
        : <String>{};

    bool hasPermission(String permissionKey) {
      return !shouldCheckPermissions || permissionKeys.contains(permissionKey);
    }

    switch (role.toLowerCase()) {
      case "admin":
        final List<DrawerItemModel> adminItems = [];
        int currentIndex = 0;

        // Stats
        if (hasPermission(adminStatsPermission)) {
          adminItems.add(DrawerItemModel(
            icon: Icons.dashboard,
            title: "Stats",
            index: currentIndex++,
            permissionKey: adminStatsPermission,
          ));
        }

        // Restaurants
        if (hasPermission(restaurantsPermission)) {
          adminItems.add(DrawerItemModel(
            icon: Icons.supervised_user_circle,
            title: "Restaurants",
            index: currentIndex++,
            permissionKey: restaurantsPermission,
          ));
        }

        // Maintain More expandable section
        if (hasPermission(maintainMorePermission)) {
          final List<DrawerItemModel> maintainChildren = [
            DrawerItemModel(
              title: "Today's Requests",
              index: currentIndex++,
              icon: Icons.history,
            ),
            DrawerItemModel(
              title: "Today's Queries",
              index: currentIndex++,
              icon: Icons.bug_report,
            ),
            DrawerItemModel(
              title: "Monthly Requests",
              index: currentIndex++,
              icon: Icons.history,
            ),
            DrawerItemModel(
              title: "Monthly Queries",
              index: currentIndex++,
              icon: Icons.bug_report,
            ),
            DrawerItemModel(
              title: "Overall Requests",
              index: currentIndex++,
              icon: Icons.speed,
            ),
            DrawerItemModel(
              title: "Overall Queries",
              index: currentIndex++,
              icon: Icons.speed,
            ),
            DrawerItemModel(
              title: "Reservations Database",
              index: currentIndex++,
              icon: Icons.storage,
            ),
          ];

          adminItems.add(DrawerItemModel(
            icon: Icons.build,
            title: "Maintain more",
            isExpandable: true,
            children: maintainChildren,
            permissionKey: maintainMorePermission,
          ));
        }

        // Events
        if (hasPermission(eventsPermission)) {
          adminItems.add(DrawerItemModel(
            icon: Icons.event,
            title: "Events",
            index: currentIndex++,
            permissionKey: eventsPermission,
          ));
        }

        // SMS Management
        if (hasPermission(smsManagementPermission)) {
          adminItems.add(DrawerItemModel(
            icon: Icons.sms,
            title: "Manage SMS & Fees",
            index: currentIndex++,
            permissionKey: smsManagementPermission,
          ));
        }

        // Campaigns
        if (hasPermission(campaignsPermission)) {
          adminItems.add(DrawerItemModel(
            icon: Icons.campaign,
            title: "Campaigns",
            index: currentIndex++,
            permissionKey: campaignsPermission,
          ));
        }

        // Add Users - only for main admin, not admin_user
        if (!shouldCheckPermissions) {
          adminItems.add(DrawerItemModel(
            icon: Icons.people,
            title: "Admin Users",
            index: currentIndex++,
          ));
        }

        // Profile - always available
        adminItems.add(DrawerItemModel(
          icon: Icons.person,
          title: "Profile",
          index: currentIndex++,
          permissionKey: profilePermission,
        ));

        return adminItems;

      case "restaurant":
      default:
        final List<DrawerItemModel> restaurantItems = [];
        int currentIndex = 0;

        // Stats
        if (hasPermission(restaurantStatsPermission)) {
          restaurantItems.add(DrawerItemModel(
            icon: Icons.trending_up_rounded,
            title: "Stats",
            index: currentIndex++,
            permissionKey: restaurantStatsPermission,
          ));
        }

        // Reservations
        if (hasPermission(reservationsPermission)) {
          restaurantItems.add(DrawerItemModel(
            icon: Icons.restaurant_outlined,
            title: "Reservations",
            index: currentIndex++,
            permissionKey: reservationsPermission,
          ));
        }

        // Availability expandable section
        if (hasPermission(availabilityPermission)) {
          final List<DrawerItemModel> availabilityChildren = [
            DrawerItemModel(
              title: "Manage Booking Time",
              index: currentIndex++,
              icon: Icons.access_time,
            ),
            DrawerItemModel(
              title: "Working Hours",
              index: currentIndex++,
              icon: Icons.schedule,
            ),
            DrawerItemModel(
              title: "Seating Area",
              index: currentIndex++,
              icon: Icons.chair,
            ),
            DrawerItemModel(
              title: "Add Cuisines & More",
              index: currentIndex++,
              icon: Icons.food_bank,
            ),
            DrawerItemModel(
              title: "Food Menu",
              index: currentIndex++,
              icon: Icons.menu_book,
            ),
            DrawerItemModel(
              title: "Gallery",
              index: currentIndex++,
              icon: Icons.photo_album,
            ),
          ];

          restaurantItems.add(DrawerItemModel(
            icon: Icons.settings_outlined,
            title: "Availability",
            isExpandable: true,
            children: availabilityChildren,
            permissionKey: availabilityPermission,
          ));
        }

        // Reservation Database
        if (hasPermission(reservationDatabasePermission)) {
          restaurantItems.add(DrawerItemModel(
            title: "Reservation Database",
            index: currentIndex++,
            icon: Icons.storage,
            permissionKey: reservationDatabasePermission,
          ));
        }

        // Maintain Reviews
        if (hasPermission(maintainReviewsPermission)) {
          restaurantItems.add(DrawerItemModel(
            title: "Maintain Reviews",
            index: currentIndex++,
            icon: Icons.reviews,
            permissionKey: maintainReviewsPermission,
          ));
        }

        // Bundle Billings
        if (hasPermission(bundleBillingsPermission)) {
          restaurantItems.add(DrawerItemModel(
            title: "Bundles and Billings",
            index: currentIndex++,
            icon: Icons.note,
            permissionKey: bundleBillingsPermission,
          ));
        }

        // Restaurant Settings
        if (hasPermission(restaurantSettingsPermission)) {
          restaurantItems.add(DrawerItemModel(
            title: "Restaurant Settings",
            index: currentIndex++,
            icon: Icons.settings,
            permissionKey: restaurantSettingsPermission,
          ));
        }

        // Share Widget
        if (hasPermission(shareWidgetPermission)) {
          restaurantItems.add(DrawerItemModel(
            title: "Share Widget",
            index: currentIndex++,
            icon: Icons.share,
            permissionKey: shareWidgetPermission,
          ));
        }

        // Add Users - only for main restaurant, not restaurant_user
        if (!shouldCheckPermissions) {
          restaurantItems.add(DrawerItemModel(
            title: "Restaurant Users",
            index: currentIndex++,
            icon: Icons.people,
          ));
        }

        // Profile - always available
        restaurantItems.add(DrawerItemModel(
          title: "Profile",
          index: currentIndex++,
          icon: Icons.person,
          permissionKey: profilePermission,
        ));

        return restaurantItems;
    }
  }
}