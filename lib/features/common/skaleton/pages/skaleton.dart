import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/services/session_controller.dart';
import 'package:tasti_restaurant_app/features/common/skaleton/data/drawer_screens.dart';
import '/features/screens.dart';
import '/config/constants/colors.dart';
import '../cubit/skaleton_cubit.dart';

class Skaleton extends StatelessWidget {
  const Skaleton({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SessionController().user;
    final userType = user?.type.toLowerCase() ?? '';
    
    // Determine base role and check permissions
    final String baseRole;
    final bool shouldCheckPermissions;
    
    switch (userType) {
      case 'admin':
      case 'admin_user':
        baseRole = 'admin';
        shouldCheckPermissions = userType == 'admin_user';
        break;
      case 'restaurant':
      case 'restaurant_user':
        baseRole = 'restaurant';
        shouldCheckPermissions = userType == 'restaurant_user';
        break;
      default:
        baseRole = 'restaurant';
        shouldCheckPermissions = false;
    }

    final items = DrawerScreens.drawerItemsForRole(
      baseRole, 
      userPermissions: shouldCheckPermissions ? user?.permissions ?? [] : null,
    );

    return BlocBuilder<SkaletonCubit, SkaletonCubitState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.darkOrange,
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ),
          drawer: CustomDrawer(
            userRole: baseRole,
            shouldCheckPermissions: shouldCheckPermissions,
            userPermissions: shouldCheckPermissions ? user?.permissions ?? [] : null,
          ),
          body: IndexedStack(
            index: state.index,
            children: items,
          ),
        );
      },
    );
  }
}

