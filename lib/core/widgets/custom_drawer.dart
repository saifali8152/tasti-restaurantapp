import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/config/constants/colors.dart';
import '/core/utils/general_extentions.dart';
import '../../features/common/skaleton/cubit/skaleton_cubit.dart';

class CustomDrawer extends StatelessWidget {
  final String userRole;
  const CustomDrawer({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SkaletonCubit>().state;

    final drawerItems = DrawerConfig.drawerItemsForRole(userRole);

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          BlocBuilder<UserCubit, UserCubitState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: (){
                  context.read<SkaletonCubit>().changeTab(userRole == 'admin'? 12 : 13);
                  Navigator.pop(context);
                },
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: AppColors.white),
                  accountName: Text(state.user?.name??'Guest'),
                  accountEmail: Text("${state.user?.email}"),
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(state.user?.profilePic??'')),
                ),
              );
            },
          ),
          ...drawerItems.map((item) {
            if (item.isExpandable) {
              return Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  textColor: AppColors.darkOrange,
                  iconColor: AppColors.darkOrange,
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  children: item.children!
                      .map((child) => _nestedDrawerItem(
                            context,
                            title: child.title,
                            index: child.index!,
                            currentIndex: state.index,
                          ))
                      .toList(),
                ),
              );
            } else {
              return _drawerItem(
                context,
                icon: item.icon,
                title: item.title,
                index: item.index!,
                currentIndex: state.index,
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required IconData icon,
      required String title,
      required int index,
      required int currentIndex}) {
    return ListTile(
      splashColor: AppColors.darkOrange.withSafeOpacity(.3),
      leading: Icon(icon,
          color: currentIndex == index ? AppColors.darkOrange : null),
      title: Text(title,
          style: TextStyle(
              color: currentIndex == index ? AppColors.darkOrange : null,
              fontWeight:
                  currentIndex == index ? FontWeight.bold : FontWeight.w400)),
      onTap: () {
        context.read<SkaletonCubit>().changeTab(index);
        Navigator.pop(context);
      },
    );
  }

  Widget _nestedDrawerItem(BuildContext context,
      {required String title, required int index, required int currentIndex}) {
    return ListTile(
      minTileHeight: 40,
      minVerticalPadding: 0,
      contentPadding: const EdgeInsets.only(left: 54),
      title: Text(title,
          style: TextStyle(
              color: currentIndex == index ? AppColors.darkOrange : null,
              fontSize: 13,
              fontWeight:
                  currentIndex == index ? FontWeight.bold : FontWeight.w400)),
      onTap: () {
        if (currentIndex == index) {
          Navigator.pop(context);
          return;
        }
        // Change the tab index in the SkaletonCubit
        // and close the drawer
        context.read<SkaletonCubit>().changeTab(index);
        Navigator.pop(context);
      },
    );
  }
}

// Model for drawer item
// Model for drawer item
class DrawerItemModel {
  final IconData icon;
  final String title;
  final int? index;
  final bool isExpandable;
  final List<DrawerItemModel>? children;

  DrawerItemModel({
    required this.icon,
    required this.title,
    this.index,
    this.isExpandable = false,
    this.children,
  });
}

// Role-based drawer configuration
class DrawerConfig {
  static List<DrawerItemModel> drawerItemsForRole(String role) {
    switch (role.toLowerCase()) {
      case "admin":
        return [
          DrawerItemModel(icon: Icons.dashboard, title: "Stats", index: 0),
          DrawerItemModel(icon: Icons.supervised_user_circle, title: "Restaurants", index: 1),
          DrawerItemModel(
            icon: Icons.build,
            title: "Maintain more",
            isExpandable: true,
            children: [
              DrawerItemModel(title: "Today's Requests", index: 2, icon: Icons.history),
              DrawerItemModel(title: "Today's Queries", index: 3, icon: Icons.bug_report),
              DrawerItemModel(title: "Monthly Requests", index: 4, icon: Icons.history),
              DrawerItemModel(title: "Monthly Queries", index: 5, icon: Icons.bug_report),
              DrawerItemModel(title: "Overall Requests", index: 6, icon: Icons.speed),
              DrawerItemModel(title: "Overall Queries", index: 7, icon: Icons.speed),
              DrawerItemModel(title: "Reservations Database", index: 8, icon: Icons.storage),
            ],
          ),
          DrawerItemModel(icon: Icons.event, title: "Events", index: 9),
          DrawerItemModel(icon: Icons.sms, title: "Manage SMS & Fees", index: 10),
          DrawerItemModel(icon: Icons.campaign, title: "Campaigns", index: 11),
          DrawerItemModel(icon: Icons.person, title: "Profile", index: 12),
        ];
      case "restaurant":
      default:
        return [
          DrawerItemModel(icon: Icons.trending_up_rounded, title: "Stats", index: 0),
          DrawerItemModel(icon: Icons.restaurant_outlined, title: "Reservations", index: 1),
          DrawerItemModel(
            icon: Icons.settings_outlined,
            title: "Availability",
            isExpandable: true,
            children: [
              DrawerItemModel(title: "Manage Booking Time", index: 2, icon: Icons.access_time),
              DrawerItemModel(title: "Working Hours", index: 3, icon: Icons.schedule),
              DrawerItemModel(title: "Seating Area", index: 4, icon: Icons.chair),
              DrawerItemModel(title: "Add Cuisines & More", index: 5, icon: Icons.food_bank),
              DrawerItemModel(title: "Food Menu", index: 6, icon: Icons.menu_book),
              DrawerItemModel(title: "Gallery", index: 7, icon: Icons.photo_album),
              DrawerItemModel(title: "Reservation Database", index: 8, icon: Icons.storage),
              DrawerItemModel(title: "Maintain Reviews", index: 9, icon: Icons.reviews),
            ],
          ),
          DrawerItemModel(title: "Bundles and Billings", index: 10, icon: Icons.note),
          DrawerItemModel(title: "Restaurant Settings", index: 11, icon: Icons.settings),
          DrawerItemModel(title: "Share Widget", index: 12, icon: Icons.share),
          DrawerItemModel(title: "Profile", index: 13, icon: Icons.person),
        ];
    }
  }
}
