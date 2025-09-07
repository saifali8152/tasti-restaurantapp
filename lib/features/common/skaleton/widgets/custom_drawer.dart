import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/features/common/auth/domain/entities/user.dart';
import 'package:tasti_restaurant_app/features/common/skaleton/cubit/skaleton_cubit.dart';
import 'package:tasti_restaurant_app/features/common/skaleton/data/drawer_config.dart';
import 'package:tasti_restaurant_app/features/common/skaleton/user_cubit/skaleton_cubit.dart';
import '/config/constants/colors.dart';
import '/core/utils/general_extentions.dart';

class CustomDrawer extends StatelessWidget {
  final String userRole;
  final bool shouldCheckPermissions;
  final List<PermissionEntity>? userPermissions;
  
  const CustomDrawer({
    super.key, 
    required this.userRole,
    this.shouldCheckPermissions = false,
    this.userPermissions,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SkaletonCubit>().state;

    final drawerItems = DrawerConfig.drawerItemsForRole(
      userRole,
      shouldCheckPermissions: shouldCheckPermissions,
      userPermissions: userPermissions,
    );

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          BlocBuilder<UserCubit, UserCubitState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: (){
                  // Find the profile index dynamically
                  final profileIndex = _findProfileIndex();
                  if (profileIndex != -1) {
                    context.read<SkaletonCubit>().changeTab(profileIndex);
                    Navigator.pop(context);
                  }
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

  int _findProfileIndex() {
    final drawerItems = DrawerConfig.drawerItemsForRole(
      userRole,
      shouldCheckPermissions: shouldCheckPermissions,
      userPermissions: userPermissions,
    );
    
    for (int i = 0; i < drawerItems.length; i++) {
      if (drawerItems[i].title.toLowerCase() == 'profile') {
        return drawerItems[i].index ?? -1;
      }
    }
    return -1;
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
        context.read<SkaletonCubit>().changeTab(index);
        Navigator.pop(context);
      },
    );
  }
}

// Model for drawer item
class DrawerItemModel {
  final IconData icon;
  final String title;
  final int? index;
  final bool isExpandable;
  final List<DrawerItemModel>? children;
  final String? permissionKey;

  DrawerItemModel({
    required this.icon,
    required this.title,
    this.index,
    this.isExpandable = false,
    this.children,
    this.permissionKey,
  });
}

// Role-based drawer configuration with permissions
