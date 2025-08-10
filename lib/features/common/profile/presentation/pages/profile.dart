import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasti_restaurant_app/config/constants/colors.dart';
import 'package:tasti_restaurant_app/core/widgets/curved_container.dart';
import 'package:tasti_restaurant_app/core/widgets/themed_app_bar.dart';
import '../../../skaleton/user_cubit/skaleton_cubit.dart';
import '/config/routes/route_name.dart';
import '/core/widgets/custom_tile.dart';
import '../widgets/profile_image.dart';
import '../../../auth/presentation/widgets/delete_account_dialog.dart';
import '../../../auth/presentation/widgets/signout_dialog.dart';
import '/core/utils/general_extentions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return BlocBuilder<UserCubit, UserCubitState>(
      builder: (context, state) {
        final user = state.user;
        return Scaffold(
          appBar: ThemedAppBar(
            height: height * 0.25, // responsive height
            subTitle: Column(
              children: [
                ProfileImage(
                  networkImageUrl: user?.profilePic ?? '',
                  isEditable: false,
                ),
                SizedBox(height: height * 0.015),
                Center(
                  child: Text(
                    user?.name ?? '',
                    style: TextStyle(
                      fontSize: width * 0.045, // responsive font
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.darkOrange,
          body: CurvedContainer(
            child: BlocBuilder<UserCubit, UserCubitState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    Text(
                      "About You",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTile(
                      leading: Icon(Icons.person_outline, size: width * 0.06),
                      title: "Personal Information",
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.profile);
                      },
                    ),
                    CustomTile(
                      leading: Icon(Icons.lock_outline, size: width * 0.06),
                      title: "Change Password",
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.changePassword);
                      },
                    ),
                    SizedBox(height: height * 0.025),
                    Text(
                      "Account",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTile(
                      leading: Icon(Icons.logout, size: width * 0.06),
                      title: "Logout",
                      onTap: () => context.showCustomDialog(LogoutDialog()),
                    ),
                    CustomTile(
                      leading:
                          Icon(Icons.delete_forever, size: width * 0.06),
                      title: "Delete Account",
                      onTap: () =>
                          context.showCustomDialog(DeleteAccountDialog()),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
