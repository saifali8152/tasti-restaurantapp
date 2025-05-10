import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/config/constants/images.dart';
import 'package:tasti_restaurant_app/core/utils/general_extentions.dart';

import '../../skaleton/presentation/bloc/cubit/skaleton_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SkaletonCubit>().state;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColors.white),
            accountName: Text("Admin"),
            accountEmail: Text("admin@example.com"),
            currentAccountPicture:
                CircleAvatar(backgroundImage: AssetImage(AppImages.profile)),
          ),
          _drawerItem(context,
              icon: Icons.trending_up_rounded,
              title: "Stats",
              index: 0,
              currentIndex: state.index),
          _drawerItem(context,
              icon: Icons.restaurant_outlined,
              title: "Reservations",
              index: 1,
              currentIndex: state.index),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              textColor: AppColors.darkOrange,
              iconColor: AppColors.darkOrange,
              leading: const Icon(Icons.settings_outlined),
              title: const Text("Availability"),
              children: [
                _nestedDrawerItem(context, title: "Manage Booking Time", index: 2, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Working Hours", index: 3, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Seating Area", index: 4, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Add Cuisines & More", index: 5, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Food Menu", index: 6, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Gallery", index: 7, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Reservation Database", index: 8, currentIndex: state.index),
                _nestedDrawerItem(context, title: "Maintain Reviews", index: 9, currentIndex: state.index),
              ],
            ),
          ),
          _drawerItem(context,
              icon: Icons.sms,
              title: "Manage SMS & Fess",
              index: 10,
              currentIndex: state.index),
          _drawerItem(context,
              icon: Icons.campaign,
              title: "Campaigns",
              index: 11,
              currentIndex: state.index),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {},
          )
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

  Widget _nestedDrawerItem(
    BuildContext context, {
    required String title,
    required int index,
    required int currentIndex,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 54),
      title: Text(title,
          style: TextStyle(
              color: currentIndex == index ? AppColors.darkOrange : null,
              fontWeight:
                  currentIndex == index ? FontWeight.bold : FontWeight.w400)),
      onTap: () {
        context.read<SkaletonCubit>().changeTab(index);
        Navigator.pop(context); // Close drawer
      },
    );
  }
}
